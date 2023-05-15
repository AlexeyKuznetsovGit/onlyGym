import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class PjUnfilledButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const PjUnfilledButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.resolveWith((states) => Size(192.w, 22.w)),
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
            return PjColors.ultraLightBlue;
          },
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.w, fontFamily: "PtRoot", fontWeight: FontWeight.w700),
      ),
    );
  }
}
