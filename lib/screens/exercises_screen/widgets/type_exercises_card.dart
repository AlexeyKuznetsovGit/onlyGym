import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class TypeExercisesCard extends StatelessWidget {
  final Function callback;
  final ExerciseModel model;
  const TypeExercisesCard({Key? key, required this.callback, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback(),
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
                height: 176.h,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 362.w,
                height: 62.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: PjColors.ultraLightBlue)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PjText(model.name!, style: PjTextStyle.bold),
                      PjText("${[for(GroupsModel elem in model.groups!) elem.values!.length].reduce((a, b) => a + b)} упражнений", style: PjTextStyle.tiny),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
