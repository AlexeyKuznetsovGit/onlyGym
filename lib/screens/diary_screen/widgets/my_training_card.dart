import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';

class MyTrainingCard extends StatefulWidget {
  const MyTrainingCard(
      {Key? key,
      required this.title,
      required this.time,
      required this.callback})
      : super(key: key);
  final String title;
  final String time;
  final Function callback;

  @override
  State<MyTrainingCard> createState() => _MyTrainingCardState();
}

class _MyTrainingCardState extends State<MyTrainingCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        widget.callback();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        width: 334.w,
        height: 208.h,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                "assets/images/exercise.png",
                width: 334.w,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 62.h,
                width: 334.w,
                decoration: BoxDecoration(
                  color: PjColors.white,
                    border:
                        Border.all(color: PjColors.ultraLightBlue, width: 1.w),
                    borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: "PtRoot",
                        height: 16 / 22,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: PjColors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.time,
                      style: TextStyle(
                        fontFamily: "PtRoot",
                        height: 12 / 20,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: PjColors.black,
                      ),
                    ),
                    SizedBox(width: 28.w),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, right: 18.w),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      CustomIcons.small_cross,
                      size: 24.w,
                      color: PjColors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
