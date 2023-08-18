import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/exercises_screen/widgets/type_exercises_card.dart';

class Carousel extends StatefulWidget {
  final List<ExerciseModel> exercises;
  final Function callback;

  Carousel({Key? key, required this.exercises, required this.callback}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late CarouselController _ctrl;
  late int _current;

  @override
  void initState() {
    _ctrl = CarouselController();
    _current = 0;
    super.initState();
  }
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _ctrl,
          items: [
            for (ExerciseModel elem in widget.exercises)
              GestureDetector(
                onTap: () {
                 context.router.push(CurrentExercisesRoute(exercise: elem));
                },
                child: TypeExercisesCard(callback: () {}, model: elem),
              )
          ],
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              widget.callback(index);
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 1,
            height: 208.h,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: true,
            enlargeFactor: 0,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [for (ExerciseModel elem in widget.exercises) TypeExercisesCard(callback: () {}, model: elem)]
              .asMap()
              .entries
              .map((entry) {
            return GestureDetector(
              onTap: () => _ctrl.animateToPage(entry.key),
              child: Container(
                width: 9.h,
                height: 9.h,
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key ? PjColors.neonBlue : PjColors.ultraLightBlue,
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
