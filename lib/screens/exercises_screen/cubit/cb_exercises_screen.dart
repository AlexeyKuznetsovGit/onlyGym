import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_exercises_screen.dart';

part 'cb_exercises_screen.freezed.dart';

class CbExercisesScreen extends Cubit<StExercisesScreen> {

  CbExercisesScreen() : super(const StExercisesScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get(method: 'method', testMode: true);
      emit(StExercisesScreen.loaded());
    } on APIException catch (e) {
      emit(StExercisesScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}