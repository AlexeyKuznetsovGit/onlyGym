import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/models/muscle_groups_model.dart';
import 'package:onlygym/repositories/dictionary_repository.dart';
import 'package:onlygym/repositories/exercise_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_new_exercise_screen.dart';

part 'cb_new_exercise_screen.freezed.dart';

class CbNewExerciseScreen extends Cubit<StNewExerciseScreen> {
  CbNewExerciseScreen() : super(const StNewExerciseScreen.init());
  List<MuscleGroupModel> muscleGroups = [];

  Future<void> getData() async {
    try {
      muscleGroups = await (getIt<DictionaryRepository>().getMuscleGroups());
      emit(StNewExerciseScreen.loaded(muscleGroups));
    } on APIException catch (e) {
      emit(StNewExerciseScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  Future<void> createNewExercise({
    required String name,
    required String description,
    required int typeExercise,
    required List<int> groupsList,
    required String pathPhoto,
    required String namePhoto,
  }) async {
    try {
      emit(StNewExerciseScreen.loading());
      log(typeExercise.toString(), name:"type");
      log(groupsList.toString(), name:"groupsList");
      await (getIt<ExerciseRepository>().createNewExercise(
          name: name,
          description: description,
          typeExercise: typeExercise,
          groupsList: groupsList,
          namePhoto: namePhoto,
          pathPhoto: pathPhoto,
          fromAssets: pathPhoto.contains('assets')));
      emit(StNewExerciseScreen.successful());
    } on APIException catch (e) {
      emit(StNewExerciseScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}
