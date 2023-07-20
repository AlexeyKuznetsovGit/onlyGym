import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class VolumeDiagram extends StatelessWidget {
  final double height;
  final int count;
  final String weekDay;

  const VolumeDiagram({
    Key? key,
    required this.height,
    required this.count,
    required this.weekDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 22.h,
          width: 24.w,
          alignment: Alignment.center,
          child: Text(
            '$count',
            style:
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, height: (12 / 22).h, color: PjColors.neonBlue),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 21.w),
          height: height < 20 ? 20.h : height,
          width: 24.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
            color: PjColors.neonBlue,
          ),
          /*child: Text(
            '$count',
            style: TextStyle(
                fontSize: 12.sp, fontWeight: FontWeight.w400, height: (12 / 22).h, color: PjColors.neonBlue),
          ),*/
        ),
        /* SizedBox(
          height: 5.w,
        ),*/
        Container(
          height: 22.h,
          width: 24.w,
          alignment: Alignment.center,
          child: Text(
            weekDay,
            style:
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, height: (12 / 22).h, color: PjColors.neonBlue),
          ),
        ),
      ],
    );
  }
}
