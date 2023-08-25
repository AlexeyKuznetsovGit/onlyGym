import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/screens/selected_exercise_screen/widget/training_component.dart';

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
  bool readMore = true;
  List<int> rounds = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: PjColors.ultraLightBlue)),
      child: Column(
        children: [
          Text(
            widget.date,
            style: TextStyle(
                fontFamily: "PtRoot",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 12 / 20,
                color: PjColors.black),
          ),
          SizedBox(
            height: 20.h,
          ),
          if (rounds.length == 1) ...[
            Container(
              height: 70.h,
              width: 304.w,
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r), border: Border.all(color: PjColors.lightBlue)),
            )
          ] else ...[
            ...List.generate(
                readMore ? 1 : rounds.length,
                (index) => Container(
                      height: 70.h,
                      width: 304.w,
                      margin: EdgeInsets.only(bottom: index == rounds.length - 1 ? 15.h : 10.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r), border: Border.all(color: PjColors.lightBlue)),
                      child: TrainingComponent(data: '1'),
                    )),
            GestureDetector(
              onTap: () {
                setState(() {
                  readMore = !readMore;
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 22.h,
                width: 294.w,
                alignment: Alignment.center,
                child: Text(
                  readMore ? 'Смотреть далее' : 'Скрыть',
                  style: TextStyle(
                      fontFamily: "PtRoot",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 14 / 22,
                      color: PjColors.neonBlue),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
