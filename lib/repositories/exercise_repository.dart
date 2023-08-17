import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/main.dart';

class ExerciseRepository{

  Future<List<ExerciseModel>> getExercises() async {
    List<ExerciseModel> list = [];
    Map<String, dynamic> response = await Api.get('', urlIndex: ApiUrls.exercise, testMode: true, isAuth: true);
    response['key'].forEach((elem){
      list.add(ExerciseModel.fromJson(elem));
    });
    return list;
  }

}