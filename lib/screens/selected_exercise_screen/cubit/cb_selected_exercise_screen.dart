import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_selected_exercise_screen.dart';

part 'cb_selected_exercise_screen.freezed.dart';

class CbSelectedExerciseScreen extends Cubit<StSelectedExerciseScreen> {

  CbSelectedExerciseScreen() : super(const StSelectedExerciseScreen.loaded());
  Future<void> getData(String dateTime, [bool loading = false]) async {
    try {


    } on APIException catch (e) {
      emit(StSelectedExerciseScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}