import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:onlygym/project_utils/pj_colors.dart';

class PjIconButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  double iconSize;

   PjIconButton({Key? key, this.onPressed, required this.icon, this.iconSize=24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize.w,
      onPressed: onPressed,
      color: PjColors.neonBlue,
      focusColor: PjColors.lightBlue,
      disabledColor: PjColors.lightGray,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(icon),
    );
  }
}
