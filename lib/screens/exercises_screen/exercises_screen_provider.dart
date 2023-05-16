import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercises_screen.dart';
import 'cubit/cb_exercises_screen.dart';
import 'cubit/st_exercises_screen.dart';

class ExercisesScreenProvider extends StatelessWidget {
  const ExercisesScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbExercisesScreen>(
      create: (context) => CbExercisesScreen(),
      child: const ExercisesScreen(),
    );
  }
}    
    