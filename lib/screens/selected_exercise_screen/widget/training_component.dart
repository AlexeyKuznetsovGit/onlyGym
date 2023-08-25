import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

class TrainingComponent extends StatelessWidget {
  final String data;

  TrainingComponent({
    required this.data,
    super.key,
  });

  List<String> trainingComponents = ['Раунд', 'Повторы', 'Вес'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
            trainingComponents.length,
            (index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: 68.w,
                      margin: EdgeInsets.only(left: 20.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            data,
                            style: TextStyle(
                                fontFamily: "PtRoot",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                height: 16 / 22,
                                color: PjColors.black),
                          ),

                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            trainingComponents[index],
                            style: TextStyle(
                                fontFamily: "PtRoot",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                height: 12 / 20,
                                color: PjColors.gray),
                          ),
                        ],
                      ),
                    ),
                    if(index != trainingComponents.length -1)...[SizedBox(
                      width: 15.w,
                    ),
                      Container(
                        width: 1.w,
                        height: 30.h,
                        color: PjColors.ultraLightBlue,
                      )]

                  ],
                ))
      ],
    );
  }
}
