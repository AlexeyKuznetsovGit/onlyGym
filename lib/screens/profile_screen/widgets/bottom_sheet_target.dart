import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';

import '../../../project_widgets/pj_buttons/pj_long_button_text.dart';

class BottomSheetTargetWidget extends StatefulWidget {
  BottomSheetTargetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetTargetWidget> createState() => _BottomSheetTargetWidgetState();
}

class _BottomSheetTargetWidgetState extends State<BottomSheetTargetWidget> {
  List<String> targets = ['Улучшение формы', 'Здоровый образ жизни', 'Похудение', 'Набор мышечной массы'];
  List<Set<MaterialState>> buttonState = [
    {MaterialState.selected},
    {MaterialState.selected},
    {MaterialState.selected},
    {MaterialState.selected},
    {MaterialState.selected}
    //так как нету состояния default, то использую то состояние selected, которого нету в кнопке pjLongButton
  ];
  List<MaterialStatesController> controllers = [
    MaterialStatesController(),
    MaterialStatesController(),
    MaterialStatesController(),
    MaterialStatesController(),
    MaterialStatesController()
  ];
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 630.h,
        decoration: BoxDecoration(
            color: PjColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
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
                4,
                (index) => Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: PjLongButtonText(
                        text: targets[index],
                        controller: controllers[index],
                        onPressed: () {
                            if (!buttonState[index].contains(MaterialState.pressed) && buttonState[index].isNotEmpty) {
                              buttonState[index] = {MaterialState.pressed};
                            } else {
                              buttonState[index] = {MaterialState.selected};
                            }
                            controllers[index].value = buttonState[index];

                        },
                      ),
                    )),
            PjFilledButton(
              text: 'Применить изменения',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

}
