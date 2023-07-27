import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';

class AthleteRepository {
  
  Future<void> getAll()async {
    await Api.get('', urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
  }
  
  
  Future<void> editAthlete({
    required String firstName,
    required String lastName,
    required String dateBirth,
    int? athleteId,
  }) async {
    var formData = athleteId != null
        ? FormData.fromMap({
            'athlete_id': athleteId,
            'first_name': firstName,
            'last_name': lastName,
            'date_birth': dateBirth,
          })
        : FormData.fromMap({
            'first_name': firstName,
            'last_name': lastName,
            'date_birth': dateBirth,
          });
    Map<String, dynamic> response =
        await Api.patch('editAthlete', body: formData, urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
  }

  Future<void> addGoal({
    required String goal,
    int? athleteId,
  }) async {
    Map<String, dynamic> body = athleteId != null
        ? {
            'athlete_id': athleteId,
            'goal': goal,
          }
        : {
            'goal': goal,
          };
    Map<String, dynamic> response =
        await Api.post('addGoal', query: body, urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
  }

  Future<void> addParams({
    required int paramId,
    required double value,
    int? athleteId,
  }) async {
    Map<String, dynamic> body = athleteId != null
        ? {
            'athlete_id': athleteId,
            'param_id': paramId,
            'value': value,
          }
        : {
            'param_id': paramId,
            'value': value,
          };
    Map<String, dynamic> response =
        await Api.post('addParams', query: body, urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
  }
  Future<void> addPhoto({
    required String pathPhoto,
    required String namePhoto,
  }) async {
    var formData =  FormData.fromMap({
      'avatar': await MultipartFile.fromFile(
        pathPhoto,
        filename: namePhoto,
      )
    });

    Map<String, dynamic> response =
    await Api.post('avatar', body: formData, urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
  }
}
