import 'dart:developer';

import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/user_model.dart';

class AthleteRepository {
  Future<List<UserModel>> getAll() async {
    List<UserModel> result = [];
    Map<String, dynamic> response = await Api.get('', urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
    for(var elm in response['key']){
      result.add(UserModel.fromJson(elm));
    }
    return result;
  }

  Future<void> addNew(UserModel user) async {
    await Api.post('addVirtualAthlete',
        body: FormData.fromMap({
          "first_name": user.firstName,
          "last_name": user.lastName,
          "date_birth": user.dateBirth,
          "weight": user.parameters![1].value,
          "height": user.parameters![0].value,
          "target": user.goal
        }),
        urlIndex: ApiUrls.athlete,
        testMode: true,
        isAuth: true);
  }

  Future<void> addAthleteByQr(int athleteId) async {
    await Api.post('addByQr',
        body: {'athlete_id': athleteId},
        urlIndex: ApiUrls.athlete,
        testMode: true,
        isAuth: true);
  }

  Future<void> editAthlete({
    required String firstName,
    required String lastName,
    required String dateBirth,
    int? athleteId,
  }) async {
    log(athleteId.toString(),name: 'athleteId');
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
        await Api.post('addParams/', body: body, urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
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
