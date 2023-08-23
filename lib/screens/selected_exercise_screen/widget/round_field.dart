import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

class RoundField extends StatefulWidget {
  final String date;

  const RoundField({
    required this.date,
    super.key,
  });

  @override
  State<RoundField> createState() => _RoundFieldState();
}

class _RoundFieldState extends State<RoundField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165.h,
      width: 334.w,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: PjColors.ultraLightBlue)),
      child: Column(
        children: [
          SizedBox(height: 15.h,),
          Text(
            widget.date,
            style: TextStyle(
                fontFamily: "PtRoot",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 12 / 20,
                color: PjColors.black),
          )
        ],
      ),
    );
  }
}
