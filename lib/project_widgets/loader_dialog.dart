
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

import '../project_utils/pj_colors.dart';

void showLoader(BuildContext context, [bool back = false]) {
  showDialog(
    barrierDismissible: false, // poka pust true
    context: context,
    builder: (context) => PjLoader()
       /* AlertDialog(
          title: Icon(CustomIcons.error, color: PjColors.neonBlue, size: 50.w,),
          content: PjText(message, align: TextAlign.center, style: PjTextStyle.bold,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),

        )*/,
  ).then((value) {
    if (back) {
      Navigator.pop(context);
    }
  });
}