import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/repositories/exercise_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_new_exercise_screen.dart';

part 'cb_new_exercise_screen.freezed.dart';

class CbNewExerciseScreen extends Cubit<StNewExerciseScreen> {

  List<ExerciseModel> exercise = [];
  CbNewExerciseScreen() : super(const StNewExerciseScreen.loaded());

  Future<void> getData() async {
    try {
      emit(StNewExerciseScreen.loaded());
    } on APIException catch (e) {
      emit(StNewExerciseScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}