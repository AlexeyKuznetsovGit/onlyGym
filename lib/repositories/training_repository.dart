import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/training_model.dart';

class TrainingRepository{
  Future<void> addTraining(int athleteId, String dateTime) async {
    await Api.post('',
        body: {
          "athlete_id": athleteId,
          "training_datetime": dateTime,
          "name": "Моя тренировка",
          "comment": "string",
          "type_id": 1
        },
        urlIndex: ApiUrls.training,
        testMode: true,
        isAuth: true);
  }

  Future<TrainingModel> getTraining(String dateTime) async {
    Map<String, dynamic> response = await Api.get('',
        query: {"date_training": dateTime},
        urlIndex: ApiUrls.training,
        testMode: true,
        isAuth: true);
    return TrainingModel.fromJson(response);
  }
}