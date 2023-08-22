import 'dart:developer';

import 'package:eticon_api/eticon_api.dart';
import 'package:flutter/services.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/main.dart';

class ExerciseRepository {
  Future<List<ExerciseModel>> getExercises() async {
    List<ExerciseModel> list = [];
    Map<String, dynamic> response = await Api.get('', urlIndex: ApiUrls.exercise, testMode: true, isAuth: true);
    response['key'].forEach((elem) {
      list.add(ExerciseModel.fromJson(elem));
    });
    return list;
  }

  Future<ExerciseModel> getCurrentExercise({required int exerciseId, int? athleteId}) async {
    Map<String, dynamic> query =
        athleteId != null ? {'exercise_id': exerciseId, 'athlete_id': athleteId} : {'exercise_id': exerciseId};
    Map<String, dynamic> response =
        await Api.get('getInstanceExercise', query: query, urlIndex: ApiUrls.exercise, testMode: true, isAuth: true);

    return ExerciseModel.fromJson(response);
  }

  Future<void> createNewExercise(
      {required String name,
      String? description,
      required int typeExercise,
      required List<int> groupsList,
      required String pathPhoto,
      required String namePhoto,
      required bool fromAssets}) async {
    String groups = groupsList.map((number) => number.toString()).join(',');
    late MultipartFile multi;
    if (fromAssets) {
      ByteData data = await rootBundle.load(pathPhoto);
      Uint8List bytes = data.buffer.asUint8List();
      multi = MultipartFile.fromBytes(bytes, filename: namePhoto);
    }
    var formData = FormData.fromMap({
      'name': name,
      'description': description ?? 'описание',
      'type_exercise': typeExercise,
      'groups': groups,
      'photos': fromAssets
          ? multi
          : await MultipartFile.fromFile(
              pathPhoto,
              filename: namePhoto,
            )
    });

    Map<String, dynamic> response =
        await Api.post('', body: formData, urlIndex: ApiUrls.exercise, testMode: true, isAuth: true);
  }
}
