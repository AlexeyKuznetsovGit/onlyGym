import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

class DescriptionField extends StatefulWidget {
  final String text;

  const DescriptionField({Key? key, required this.text}) : super(key: key);

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  bool readMore = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      padding: EdgeInsets.only(left: 20.w, top: 20.w, bottom: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), border: Border.all(width: 1.w, color: PjColors.ultraLightBlue)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Описание',
            style: TextStyle(
                fontFamily: "PtRoot",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                height: 16 / 22,
                color: PjColors.neonBlue),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: 294.w,
            child: Text(widget.text,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontFamily: "PtRoot",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: PjColors.black,
                ),
                maxLines: readMore ? 3 : null,
                overflow: readMore ? TextOverflow.ellipsis : null),
          ),
          SizedBox(
            height: 15.h,
          ),
          if (widget.text.length >= 105)
            GestureDetector(
              onTap: () {
                setState(() {
                  print(widget.text.length);
                  readMore = !readMore;
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 22.h,
                width: 294.w,
                alignment: Alignment.center,
                child: Text(
                  readMore ? 'Смотреть далее' : 'Свернуть',
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
      ),
    );
  }
}
