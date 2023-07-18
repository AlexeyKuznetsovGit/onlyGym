import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

class PjLongButtonText extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final MaterialStatesController controller;

  const PjLongButtonText({Key? key, required this.text, this.onPressed, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        statesController: controller,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return TextStyle(color: PjColors.white, fontWeight: FontWeight.w500, fontSize: 14.sp, height: (14 / 22).h);
              }

              return TextStyle(color: PjColors.black, fontWeight: FontWeight.w500, fontSize: 14.sp, height: (14 / 22).h);
            },
          ),
          alignment: Alignment.centerLeft,
          iconSize: MaterialStateProperty.resolveWith((states) => 24.w),
          fixedSize: MaterialStateProperty.resolveWith((states) => Size(334.w, 52.w)),
          animationDuration: Duration(milliseconds: 20),
          shape: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                side: const BorderSide(color: PjColors.neonBlue),
                borderRadius: BorderRadius.circular(30.r),
              );
            }

            if (states.contains(MaterialState.disabled)) {
              return RoundedRectangleBorder(
                side: const BorderSide(color: PjColors.lightGray),
                borderRadius: BorderRadius.circular(30.r),
              );
            }

            return RoundedRectangleBorder(
              side: const BorderSide(color: PjColors.ultraLightBlue),
              borderRadius: BorderRadius.circular(30.r),
            );
          }),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (_) {
              return Colors.transparent;
            },
          ),
          shadowColor: MaterialStateProperty.resolveWith<Color>(
            (_) {
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return PjColors.white;
              if (states.contains(MaterialState.disabled)) return PjColors.lightGray;
              return PjColors.black;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return PjColors.neonBlue;
              return Colors.transparent;
            },
          ),
        ),
        child: Center(
          child: Text("$text"),
        ));
  }
}
