import 'package:auto_route/auto_route.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/exercises_screen/cubit/cb_exercises_screen.dart';

@RoutePage()
class NewExerciseScreen extends StatefulWidget implements AutoRouteWrapper {
  const NewExerciseScreen({Key? key}) : super(key: key);

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbExercisesScreen>(
      create: (context) => CbExercisesScreen()..getData(),
      child: this,
    );
  }
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(
        leading: () {
          context.router.pop();
        },
        title: "Новое упражнение",
      ),
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
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          SizedBox(width: 334.w, height: 180.h, child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              "assets/images/exercise.png",
              width: 334.w,
              height: 176.h,
              fit: BoxFit.cover,
            ),
          ),)
        ],
      ),
    );
  }
}
