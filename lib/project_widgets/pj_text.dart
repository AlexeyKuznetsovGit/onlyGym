import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

enum PjTextStyle{
  h1,
  title,
  bold,
  regular,
  medium,
  tiny,
  downmenu
}

class PjText extends StatelessWidget {
  final String text;
  final Color? color;
  final PjTextStyle style;

  const PjText(this.text, {Key? key, required this.style, this.color=PjColors.black}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize.w,
        color: color,
        //height: height,
      ),
    );
  }

  FontWeight get fontWeight{
    if (style == PjTextStyle.h1 || style == PjTextStyle.title || style == PjTextStyle.bold) return FontWeight.w700;
    if (style == PjTextStyle.medium || style == PjTextStyle.tiny) return FontWeight.w500;
    if (style == PjTextStyle.regular || style == PjTextStyle.downmenu) return FontWeight.w400;
    return FontWeight.w400;
  }

  double get fontSize{
    if(style == PjTextStyle.h1) return 28;
    if(style == PjTextStyle.title) return 20;
    if(style == PjTextStyle.bold || style == PjTextStyle.regular) return 16;
    if(style == PjTextStyle.medium) return 14;
    if(style == PjTextStyle.tiny) return 12;
    if(style == PjTextStyle.downmenu) return 10;
    return 14;
  }

  double get height{
    if(style == PjTextStyle.h1) return 28 / 22;
    if(style == PjTextStyle.title) return 20 / 22;
    if(style == PjTextStyle.bold || style == PjTextStyle.regular) return 16 / 22;
    if(style == PjTextStyle.medium) return 14 / 22;
    if(style == PjTextStyle.tiny) return 12 / 20;
    if(style == PjTextStyle.downmenu) return 10 / 12;
    return 14;
  }

  String get fontFamily{
    if(style == PjTextStyle.downmenu) return "SFPro";
    return "PtRoot";
  }


}
  