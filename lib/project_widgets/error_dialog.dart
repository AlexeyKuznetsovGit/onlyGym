
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

import '../project_utils/pj_colors.dart';

void showAlertDialog(BuildContext context, String message, [Function()? onTap]) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Icon(CustomIcons.error, color: PjColors.neonBlue, size: 50.w,),
      content: PjText(message, align: TextAlign.center, style: PjTextStyle.bold,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),

    ),
  );
  /*Get.dialog(
      DialogError(
        message: message,
      ),
      barrierDismissible: true);*/
}
/*
class DialogError extends StatelessWidget {
  const DialogError({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 294.w,
            height: 164.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(CustomIcons.error,color: PjColors.neonBlue,),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    message,
                    style: PjStyles.ptRootUIBold16,
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                ]),

              ],
            ),
          )
        ],
      ),
    );
  }
}
*/
