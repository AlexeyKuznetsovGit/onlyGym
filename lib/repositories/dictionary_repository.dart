import 'dart:developer';

import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/muscle_groups_model.dart';

class DictionaryRepository{

  Future<List<MuscleGroupModel>> getMuscleGroups() async {
    List<MuscleGroupModel> list = [];
    Map<String, dynamic> response = await Api.get('', urlIndex: ApiUrls.dictionary, testMode: true, isAuth: false);
    response['muscle_groups'].forEach((elem){
      list.add(MuscleGroupModel.fromJson(elem));
    });
    return list;
  }

}