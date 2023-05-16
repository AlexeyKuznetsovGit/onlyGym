import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';


// Страшная пиздятина

class PjLongButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final IconData icon;

  const PjLongButton(
      {Key? key, required this.text, this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        iconSize: MaterialStateProperty.resolveWith((states) => 24.w),
        fixedSize:
            MaterialStateProperty.resolveWith((states) => Size(334.w, 52.w)),
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
        iconColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return PjColors.white;
            if (states.contains(MaterialState.disabled)) return PjColors.lightGray;
            return PjColors.black;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return PjColors.neonBlue;
            return Colors.transparent;
          },
        ),
      ),
      icon: Icon(icon),
      label: Text(
        " $text",
        style: TextStyle(
            fontSize: 16.w, fontFamily: "PtRoot", fontWeight: FontWeight.w700),
      ),
    );
  }
}
