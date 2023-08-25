import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class PjFilledButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color buttonColor;

  const PjFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = PjColors.neonBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
        side: buttonColor == PjColors.neonBlue
            ? BorderSide.none
            : BorderSide(
                color: PjColors.ultraLightBlue, // Цвет границы
                width: 1.w, // Толщина границы
              ),
      ),
      child: MaterialButton(
          animationDuration: Duration(milliseconds: 25),
          onPressed: onPressed,
          color: buttonColor,
          focusColor: PjColors.lightBlue,
          disabledColor: PjColors.lightGray,
          height: 52.h,
          minWidth: 232.w,
          splashColor: Colors.transparent,
          child: Text(
            text,
            style: TextStyle(
                fontFamily: "PtRoot",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: buttonColor == PjColors.neonBlue ? PjColors.white : PjColors.black),
          ) /*PjText(
          text,
          style: PjTextStyle.bold,
          color: PjColors.white,
        ),*/
          ),
    );
  }
}
