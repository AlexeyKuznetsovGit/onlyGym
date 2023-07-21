import 'st_current_exercises_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbCurrentExercisesScreen extends Cubit<StCurrentExercisesScreen> {
  CbCurrentExercisesScreen() : super(StCurrentExercisesScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get( 'method', testMode: true);
      emit(StCurrentExercisesScreenLoaded());
    } on APIException catch (e) {
      emit(StCurrentExercisesScreenError(error: e.code));
    }
  }
}
    