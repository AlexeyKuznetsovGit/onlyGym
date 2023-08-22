import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/screens/exercises_screen/widgets/button_exercise_list.dart';
import 'package:onlygym/screens/exercises_screen/widgets/exercise_card.dart';

class ExerciseList extends StatefulWidget {
  final List<ExerciseModel> exercises;
  final int trainType;

  const ExerciseList({Key? key, required this.exercises, required this.trainType}) : super(key: key);

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  late int group;

  @override
  void initState() {
    group = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            itemCount: widget.exercises[widget.trainType].groups!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ButtonExerciseList(
                isActive: index == group,
                index: index,
                callback: () {
                  setState(() {
                    group = index;
                  });
                },
                text: widget.exercises[widget.trainType].groups![index].name!,
              );
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Flexible(
          child: ListView.separated(
            itemCount: widget.exercises[widget.trainType].groups![group].values!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: ExerciseCard(
                    value: widget.exercises[widget.trainType].groups![group].values![index],
                    callback: () {
                      print("Гена пидор");
                    }),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10.h,
              );
            },
          ),
        ),
      ],
    );
  }
}
