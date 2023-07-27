import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_qr.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:onlygym/screens/profile_screen/widgets/volumeDiagram.dart';

import '../../../project_widgets/pj_text_field.dart';

enum BottomSheetType { init, edit, look }

class BottomSheetBodyPartsWidget extends StatefulWidget {
  final String title;
  BottomSheetType type;
  double height;
  final String data;
  final CbProfileScreen cubit;
  final int idParam;

  BottomSheetBodyPartsWidget(
      {Key? key,
      required this.data,
      required this.cubit,
      required this.title,
      required this.type,
      required this.idParam,
      required this.height})
      : super(key: key);

  @override
  State<BottomSheetBodyPartsWidget> createState() => _BottomSheetBodyPartsWidgetState();
}

class _BottomSheetBodyPartsWidgetState extends State<BottomSheetBodyPartsWidget> {
  /*Set<MaterialState> changeButtonState = {MaterialState.selected};
  Set<MaterialState> statisticsButtonState = {MaterialState.selected};*/
  final _formKeyEdit = GlobalKey<FormState>();
  bool isPressed = false;

  MaterialStatesController changeController = MaterialStatesController();
  MaterialStatesController statisticsController = MaterialStatesController();

  TextEditingController controllerVolume = TextEditingController();

  List<int> counts = [45, 25, 30, 10, 20, 35, 15];
  int max = 0;
  List<String> weeks = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];

  @override
  void initState() {
    max = counts.reduce((curr, next) => curr > next ? curr : next);
    if (max == 0) {
      max = 1;
    }
    if (widget.data == "-") {
      controllerVolume.text = '';
    } else {
      controllerVolume.text = widget.data;
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
              if (widget.type == BottomSheetType.init) ...[
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
                      builder: (BuildContext context) {
                        return BottomSheetBodyPartsWidget(
                          cubit: widget.cubit,
                          data: widget.data,
                          height: 270.h,
                          title: widget.title,
                          type: BottomSheetType.edit,
                          idParam: widget.idParam,
                        );
                      },
                    );
                  },
                  text: 'Редактировать значение',
                  icon: CustomIcons.edit,
                  controller: changeController,
                ),
                SizedBox(
                  height: 20.h,
                ),
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
                      builder: (BuildContext context) {
                        return BottomSheetBodyPartsWidget(
                          idParam: widget.idParam,
                          cubit: widget.cubit,
                          data: widget.data,
                          height: 337.h,
                          title: widget.title,
                          type: BottomSheetType.look,
                        );
                      },
                    );
                  },
                  text: 'Смотреть динамику объёма',
                  icon: CustomIcons.analytics,
                  controller: statisticsController,
                )
              ] else if (widget.type == BottomSheetType.edit) ...[
                Form(
                  key: _formKeyEdit,
                  child: PjTextField(
                    type: PjTextFieldStyle.params,
                    title: widget.title,
                    controller: controllerVolume,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                PjFilledButton(
                  text: 'Применить изменения',
                  onPressed: () {
                    if (_formKeyEdit.currentState!.validate()) {
                      widget.cubit.changeOneParam(
                          title: widget.title, idParam: widget.idParam, value: double.parse(controllerVolume.text));
                    }
                  },
                )
              ] else ...[
                Container(
                  height: 191.h,
                  width: 334.w,
                  padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r), border: Border.all(color: PjColors.ultraLightBlue)),
                  child: Container(
                    width: 294.w,
                    height: 161.h,
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          behavior: HitTestBehavior.translucent,
                          child: VolumeDiagram(
                            height: 87 / (max / counts[index]),
                            //87 это максимальная высота одного элемента диаграммы
                            count: counts[index],
                            weekDay: weeks[index],
                          ),
                        );
                      },
                      itemCount: weeks.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
