import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/athletes_screen/cubit/cb_athletes_screen.dart';
import 'package:onlygym/screens/diary_screen/cubit/cb_diary_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BottomSheetAddTraining extends StatefulWidget {
  final String title;
  final double height;
  final bool isNewTraining;
  final CbDiaryScreen cubit;
  final int? athleteId;

  const BottomSheetAddTraining(
      {Key? key, required this.title, this.athleteId, required this.cubit, required this.height, this.isNewTraining = true})
      : super(key: key);

  @override
  State<BottomSheetAddTraining> createState() => _BottomSheetAddTrainingState();
}

class _BottomSheetAddTrainingState extends State<BottomSheetAddTraining> {
  MaterialStatesController buttonCtrl = MaterialStatesController();

  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
              color: PjColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.only(right: 16.w),
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
                            widget.title,
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
              if (widget.isNewTraining) ...[
                PjLongButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      isScrollControlled: true,
                      barrierColor: PjColors.black.withOpacity(0.5),
                      context: context,
                      builder: (ctx) {
                        return BottomSheetAddTraining(
                          cubit: widget.cubit,
                          isNewTraining: false,
                          height: 270.h,
                          title: 'Настройка тренировки',
                        );
                      },
                    );
                  },
                  text: 'Моя тренировка',
                  icon: CustomIcons.my_training,
                  controller: buttonCtrl,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PjLongButton(
                  onPressed: () async {
                 dynamic res = await context.router.push(AthletesRoute(isChoiceAthlete: true));
                    if (res != null){
                      print(res);
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        isScrollControlled: true,
                        barrierColor: PjColors.black.withOpacity(0.5),
                        context: context,
                        builder: (ctx) {
                          return BottomSheetAddTraining(
                            athleteId: res,
                            cubit: widget.cubit,
                            isNewTraining: false,
                            height: 270.h,
                            title: 'Настройка тренировки',
                          );
                        },
                      );
                    }
                  },
                  text: 'Чужая тренировка',
                  icon: CustomIcons.notmy_training,
                  controller: buttonCtrl,
                ),
              ] else ...[
                Form(
                    key: _formKey,
                    child: PjTextField(
                        onChanged: (val) {
                          setState(() {});
                        },
                        type: PjTextFieldStyle.time, // пока так
                        title: "Время тренировки",
                        controller: controller)),
                if (isPressed && _formKey.currentState != null && !_formKey.currentState!.validate())
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      controller.text.isEmpty ? 'Пожалуйста, заполните поле' : 'Введено некорректное время',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(
                  height: 20.h,
                ),
                PjFilledButton(
                    text: "Применить изменения",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.router.pop();
                         widget.cubit.addTraining(
                             widget.athleteId, DateFormat("yyyy-MM-dd").format(widget.cubit.currentDate), '${controller.text}:00');
                      } else {
                        setState(() {
                          isPressed = true;
                        });
                      }
                    }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
