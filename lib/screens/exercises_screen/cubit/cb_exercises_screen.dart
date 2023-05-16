import 'st_exercises_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbExercisesScreen extends Cubit<StExercisesScreen> {
  CbExercisesScreen() : super(StExercisesScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StExercisesScreenLoaded());
    } on APIException catch (e) {
      emit(StExercisesScreenError(error: e.code));
    }
  }
}
    