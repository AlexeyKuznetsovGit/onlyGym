import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/repositories/exercise_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_current_exercises_screen.dart';

part 'cb_current_exercises_screen.freezed.dart';

class CbCurrentExercisesScreen extends Cubit<StCurrentExercisesScreen> {

  List<ExerciseModel> exercise = [];
  CbCurrentExercisesScreen() : super(const StCurrentExercisesScreen.loaded());

  Future<void> getData() async {
    try {
      emit(StCurrentExercisesScreen.loaded());
    } on APIException catch (e) {
      emit(StCurrentExercisesScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}