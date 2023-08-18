import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class ButtonExerciseList extends StatelessWidget {
  final bool isActive;
  final int index;
  final Function() callback;
  final String text;
  const ButtonExerciseList({Key? key, required this.isActive, required this.index, required this.callback, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w, left: index == 0 ? 28.w : 0.w),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? PjColors.neonBlue : PjColors.white,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: isActive ? PjColors.neonBlue :PjColors.ultraLightBlue)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PjText(text, style: PjTextStyle.regular, color: isActive ? PjColors.white : PjColors.black),
          ),
        ),
      ),
    );
  }
}
