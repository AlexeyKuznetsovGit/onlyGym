import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/exercises_screen/cubit/cb_exercises_screen.dart';

@RoutePage()
class ExercisesScreen extends StatefulWidget implements AutoRouteWrapper {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbExercisesScreen>(
      create: (context) => CbExercisesScreen(),
      child: this,
    );
  }
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(),
      body: BlocConsumer<CbExercisesScreen, StExercisesScreen>(
        listener: (context, state) =>
            state.whenOrNull(error: (code, message) => showAlertDialog(context, message ?? '')),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          loading: () => const PjLoader(),
          loaded: () => _buildBodyContent(context),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Center(
      child: Text('Exercises'),
    );
  }
}
