import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/repositories/exercise_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_exercises_screen.dart';

part 'cb_exercises_screen.freezed.dart';

class CbExercisesScreen extends Cubit<StExercisesScreen> {

  List<ExerciseModel> exercise = [];
  CbExercisesScreen() : super(const StExercisesScreen.init());

  Future<void> getData() async {
    print("Keks");
    try {
      exercise = await (getIt<ExerciseRepository>().getExercises());
      emit(StExercisesScreen.loaded());
    } on APIException catch (e) {
      emit(StExercisesScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}