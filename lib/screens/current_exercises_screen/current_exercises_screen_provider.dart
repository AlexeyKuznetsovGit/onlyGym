import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'current_exercises_screen.dart';
import 'cubit/cb_current_exercises_screen.dart';
import 'cubit/st_current_exercises_screen.dart';

class CurrentExercisesScreenProvider extends StatelessWidget {
  const CurrentExercisesScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbCurrentExercisesScreen>(
      create: (context) => CbCurrentExercisesScreen(),
      child: const CurrentExercisesScreen(),
    );
  }
}    
    