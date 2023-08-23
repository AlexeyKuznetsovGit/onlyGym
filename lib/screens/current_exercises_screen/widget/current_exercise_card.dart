import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class CurrentExerciseCard extends StatefulWidget {
  const CurrentExerciseCard(
      {Key? key, required this.title, required this.type, required this.callback, required this.value})
      : super(key: key);
  final String title;
  final String type;
  final Function callback;
  final ValuesModel value;

  @override
  State<CurrentExerciseCard> createState() => _CurrentExerciseCardState();
}

class _CurrentExerciseCardState extends State<CurrentExerciseCard> {
  late bool isTouch;

  @override
  void initState() {
    isTouch = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) {
        setState(() => isTouch = true);
      },
      onPanEnd: (_) {
        setState(() => isTouch = false);
        widget.callback();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        width: 334.w,
        height: 180.h,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: widget.value.photos == null
                  ? Image.asset(
                      "assets/images/exercise.png",
                      width: 334.w,
                      height: 180.h,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "${PjUtils.imageUrl}${widget.value.photos![0].url}",
                      width: 334.w,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              width: 334.w,
              height: 180.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: isTouch ? Color.fromRGBO(46, 44, 47, 0.3) : Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: PjText(
                  widget.title,
                  style: PjTextStyle.title,
                  color: PjColors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PjColors.white),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    child: PjText(
                      widget.type,
                      style: PjTextStyle.tiny,
                      color: PjColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
