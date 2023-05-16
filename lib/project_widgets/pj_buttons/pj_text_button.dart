import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

enum PjTextButtonType{
  center,
  left,
}

class PjTextButton extends StatelessWidget {
  final String text;
  final PjTextButtonType type;
  final Function()? onPressed;

  const PjTextButton({Key? key, required this.text, this.onPressed, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: type == PjTextButtonType.left ? Alignment.centerLeft : Alignment.center,
        minimumSize: MaterialStateProperty.resolveWith((states){
          if(type == PjTextButtonType.center)  return Size(294.w, 22.w);
          return Size(30.w, 22.w);
        }),
        animationDuration: Duration(milliseconds: 15),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
              (_) {
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return PjColors.neonBlue;
            return PjColors.lightBlue;
          },
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.w, fontFamily: "PtRoot", fontWeight: FontWeight.w500),
      ),
    );
  }
}
