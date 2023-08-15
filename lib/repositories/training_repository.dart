import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/training_model.dart';

class TrainingRepository {
  Future<void> addTraining(int? athleteId, String date,String time) async {
    Map<String, dynamic> body = athleteId != null
        ? {
            "athlete_id": athleteId,
            "training_datetime": "$date $time",
            "name": "Моя тренировка",
            "comment": "string",
            "type_id": 1
          }
        : {"training_datetime": "$date $time", "name": "Моя тренировка", "comment": "string", "type_id": 1};
    await Api.post('', body: body, urlIndex: ApiUrls.training, testMode: true, isAuth: true);
  }

  Future<TrainingModel> getTraining(String dateTime) async {
    Map<String, dynamic> response =
        await Api.get('', query: {"date_training": dateTime}, urlIndex: ApiUrls.training, testMode: true, isAuth: true);
    return TrainingModel.fromJson(response);
  }
}
