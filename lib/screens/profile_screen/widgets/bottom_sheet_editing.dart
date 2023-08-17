import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';

class BottomSheetEditingWidget extends StatefulWidget {
  final CbProfileScreen cubit;
  final int? athleteId;

  BottomSheetEditingWidget({Key? key, required this.cubit, this.athleteId}) : super(key: key);

  @override
  State<BottomSheetEditingWidget> createState() => _BottomSheetEditingWidgetState();
}

class _BottomSheetEditingWidgetState extends State<BottomSheetEditingWidget> {
  final _formKeyEdit = GlobalKey<FormState>();
  List<String> titles = ['Имя', "Фамилия", "Дата рождения", "Вес, кг", 'Рост, см'];
  bool isPressed = false;
  List<String> data = [
    SgAppData.instance.user.firstName!,
    SgAppData.instance.user.lastName!,
    SgAppData.instance.user.dateBirth!,
    SgAppData.instance.user.parameters![1].value.toString(),
    SgAppData.instance.user.parameters![0].value.toString()
  ];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    if (widget.athleteId == null) {
      data[2] = formatDateToISO(SgAppData.instance.user.dateBirth!);
      controllers = generateTextEditingControllers(data);
    } else {
      titles.clear();
      data.clear();

      titles = ["Дата рождения", "Вес, кг", 'Рост, см'];
      data = [
        formatDateToISO(widget.cubit.user.dateBirth!),
        widget.cubit.user.parameters![1].value.toString(),
        widget.cubit.user.parameters![0].value.toString(),
      ];
      controllers = generateTextEditingControllers(data);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: widget.athleteId == null ? 560.h : 414.h,
            decoration: BoxDecoration(
                color: PjColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
            child: Form(
              key: _formKeyEdit,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16.w),
                    height: 42.h,
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              CustomIcons.cross,
                              size: 24.w,
                              color: PjColors.black,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: PjText(
                                'Редактирование',
                                style: PjTextStyle.title,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ...List.generate(
                      data.length,
                      (index) => Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: PjTextField(
                              suffixText: index == data.length - 2
                                  ? 'кг'
                                  : index == data.length - 1
                                      ? 'см'
                                      : null,
                              type: getPjTextFieldStyle(index, widget.athleteId),
                              title: titles[index],
                              controller: controllers[index],
                            ),
                          )),
                  if (isPressed && _formKeyEdit.currentState != null && !_formKeyEdit.currentState!.validate()) ...[
                    Text(
                      'Пожалуйста, заполните/измените отмеченные поля',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                  PjFilledButton(
                    text: 'Применить изменения',
                    onPressed: () {
                      if (_formKeyEdit.currentState!.validate()) {
                        widget.athleteId == null
                            ? widget.cubit.editProfile(
                                firstName: controllers[0].text,
                                lastName: controllers[1].text,
                                dateBirth: controllers[2].text,
                                weight: double.parse(controllers[3].text),
                                height: double.parse(controllers[4].text))
                            : widget.cubit.editProfile(
                                firstName: widget.cubit.user.firstName!,
                                lastName: widget.cubit.user.lastName!,
                                dateBirth: controllers[0].text,
                                weight: double.parse(controllers[1].text),
                                height: double.parse(controllers[2].text),
                                athleteId: widget.athleteId);
                      } else {
                        setState(() {
                          isPressed = true;
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TextEditingController> generateTextEditingControllers(List<String> data) {
    return List<TextEditingController>.generate(data.length, (index) => TextEditingController(text: data[index]));
  }

  String formatDateToISO(String inputDate) {
    DateFormat inputDateFormat = DateFormat("yyyy-MM-dd");
    DateFormat outputDateFormat = DateFormat("dd.MM.yyyy");

    try {
      DateTime date = inputDateFormat.parseStrict(inputDate);
      String formattedDate = outputDateFormat.format(date);
      return formattedDate;
    } catch (e) {
      print('Ошибка при преобразовании даты: $e');
      return '';
    }
  }

  PjTextFieldStyle getPjTextFieldStyle(int index, int? athleteId) {
    if (athleteId == null) {
      if (index < 2) {
        return PjTextFieldStyle.text;
      } else if (index == 2) {
        return PjTextFieldStyle.date;
      } else {
        return PjTextFieldStyle.params;
      }
    } else {
      if (index == 0) {
        return PjTextFieldStyle.date;
      } else {
        return PjTextFieldStyle.params;
      }
    }
  }
}
