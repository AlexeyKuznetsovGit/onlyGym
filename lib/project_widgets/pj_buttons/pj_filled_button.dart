import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class PjFilledButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const PjFilledButton({super.key, required this.text, required this.onPressed, });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.r)),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        animationDuration:Duration(milliseconds: 25) ,
        onPressed: onPressed,
        color: PjColors.neonBlue,
        focusColor: PjColors.lightBlue,
        disabledColor: PjColors.lightGray,
        height: 52.w,
        minWidth: 232.w,
        splashColor: Colors.transparent,
        child: PjText(
          text,
          style: PjTextStyle.bold,
          color: PjColors.white,
        ),
      ),
    );
  }
}
