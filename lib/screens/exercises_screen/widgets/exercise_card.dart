import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

enum _ExerciseCardType { base, checkbox, delete }

class ExerciseCard extends StatefulWidget {
  ExerciseCard({Key? key, required this.callback, this.value}) : super(key: key) {
    type = _ExerciseCardType.base;
  }

  ExerciseCard.chekbox({Key? key, required this.callback, this.value}) : super(key: key) {
    type = _ExerciseCardType.checkbox;
  }

  ExerciseCard.delete({Key? key, required this.callback, required this.deleteCallback}) : super(key: key) {
    type = _ExerciseCardType.delete;
  }

  late _ExerciseCardType type;
  final Function callback;
  ValuesModel? value;
  Function? deleteCallback;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late bool isTouch;
  late bool isCheck;

  @override
  void initState() {
    isTouch = false;
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // onPanStart: (_) {
      //   setState(() => isTouch = true);
      // },
      // onPanEnd: (_) {
      //   setState(() => isTouch = false);
      //   if (widget.type == _ExerciseCardType.checkbox) isCheck = !isCheck;
      //   widget.callback();
      // },
      onTap: () {
        setState(() {
          if (widget.type == _ExerciseCardType.checkbox) {
            isCheck = !isCheck;
          }
        });

        widget.callback();
      },
      child: Container(
        width: 334.w,
        decoration: BoxDecoration(
          border: Border.all(color: PjColors.ultraLightBlue, width: 1.w),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    widget.value?.photos?[0].url != null
                        ? "${PjUtils.imageUrl}${widget.value?.photos?[0].url}"
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3DmL_9tM3aFKiBpqYvUmdvEMg105Vg7p0EjjjZxgsjA&s",
                    width: 54.w,
                    height: 54.h,
                    fit: BoxFit.cover,
                    opacity: AlwaysStoppedAnimation(isTouch ? 0.6 : 1),
                  )),
              SizedBox(
                width: 10.w,
              ),
              Container(
                  width: 211.w,
                  child: Text(widget.value?.name ?? "Канаты - чередование волн в полуприседе", //Пока так оставлю
                      style: TextStyle(
                          color: widget.type == _ExerciseCardType.checkbox
                              ? PjColors.black
                              : (isTouch ? PjColors.gray : PjColors.black),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: "PtRoot",
                          leadingDistribution: TextLeadingDistribution
                              .even)) /*PjText("Канаты - чередование волн в полуприседе",
                      style: PjTextStyle.bold,
                      dontUseHeightBlyad: true,
                      color: widget.type == _ExerciseCardType.checkbox
                          ? PjColors.black
                          : (isTouch ? PjColors.gray : PjColors.black))*/
                  ),
              const Spacer(),
              if (widget.type == _ExerciseCardType.checkbox) ...[
                SvgPicture.asset(isCheck ? PjIcons.check : PjIcons.notCheck),
              ],
              if (widget.type == _ExerciseCardType.delete) ...[
                Icon(CustomIcons.small_cross, color: isTouch ? PjColors.ultraLightBlue : PjColors.lightBlue)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
