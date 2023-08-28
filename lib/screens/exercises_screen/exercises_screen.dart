import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/exercises_screen/cubit/cb_exercises_screen.dart';
import 'package:onlygym/screens/exercises_screen/widgets/carousel.dart';
import 'package:onlygym/screens/exercises_screen/widgets/exercise_list.dart';

@RoutePage()
class ExercisesScreen extends StatefulWidget implements AutoRouteWrapper {
  final bool isChoice;
  const ExercisesScreen({Key? key, this.isChoice = false}) : super(key: key);
  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbExercisesScreen>(
      create: (context) => CbExercisesScreen()..getData(),
      child: this,
    );
  }
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late int trainType;



  @override
  void initState() {
    trainType = 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(title: "Упражнения",),
      body: BlocConsumer<CbExercisesScreen, StExercisesScreen>(
        listener: (context, state) =>
            state.whenOrNull(error: (code, message) => showAlertDialog(context, message ?? '')),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          init: () => const PjLoader(),
          loaded: () => _buildBodyContent(context),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h,),
        Carousel(isChoice: widget.isChoice,exercises: BlocProvider.of<CbExercisesScreen>(context).exercise, callback: (int i){
          setState(() {
            trainType = i;
          });
        },),
        Expanded(child: ExerciseList(exercises: BlocProvider.of<CbExercisesScreen>(context).exercise, trainType: trainType, isChoice: widget.isChoice,)),
      ],
    );
  }
}
