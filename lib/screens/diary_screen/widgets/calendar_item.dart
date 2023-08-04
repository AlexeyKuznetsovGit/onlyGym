import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

class CalendarItem extends StatefulWidget {
 final DateTime date;
 final DateTime selectedDate;
 final Function() onItemTap;
 final bool isContainsTraining;

  CalendarItem(
      {Key? key,
        required this.date,
        required this.selectedDate,
        required this.isContainsTraining,
        required this.onItemTap})
      : super(key: key);

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onItemTap();
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(right: 5.w),
        height: 60.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: background,
          border: Border.all(width: 1.w, color: widget.isContainsTraining ? PjColors.neonBlue : PjColors.ultraLightBlue),
          borderRadius: BorderRadius.circular(20.r),
        ),
        duration: Duration(microseconds: 200),
        curve: Curves.easeIn,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
                getWeekStr(),
                style: TextStyle(
                  fontFamily: "PtRoot",
                  height: 12/20,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: activ,
                )
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
                "${widget.date.day}",
                style:TextStyle(
                  fontFamily: "PtRoot",
                  height: 16/22,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: activ,
                )

            ),
          ],
        ),
      ),
    );
  }

  String getWeekStr() {
    String day = '';
    switch (widget.date.weekday) {
      case 1:
        day = "пн";
        break;
      case 2:
        day = "вт";
        break;
      case 3:
        day = "ср";
        break;
      case 4:
        day = "чт";
        break;
      case 5:
        day = "пт";
        break;
      case 6:
        day = "сб";
        break;
      case 7:
        day = "вс";
        break;
    }
    return day;
  }

  bool get compareDates =>
      (widget.date.day == widget.selectedDate.day) &&
          (widget.date.month == widget.selectedDate.month) &&
          (widget.date.year == widget.selectedDate.year);

  Color get background =>
      compareDates ? PjColors.neonBlue : Colors.transparent;

  Color get activ =>
      compareDates ? PjColors.white : PjColors.black;
}