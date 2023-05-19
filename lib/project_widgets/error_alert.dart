import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Material(
        color: Colors.black.withOpacity(0.2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 294.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30.h,),
                  Icon(CustomIcons.error, color: PjColors.neonBlue, size: 50.w,),
                  SizedBox(height: 10.h,),
                  Container(
                    width: 260.w,
                      child: PjText(text, style: PjTextStyle.bold, align: TextAlign.center,),),
                  SizedBox(height: 30.h,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
