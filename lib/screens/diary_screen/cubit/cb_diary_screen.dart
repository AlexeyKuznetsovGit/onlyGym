import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/training_model.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/training_repository.dart';

part 'st_diary_screen.dart';

part 'cb_diary_screen.freezed.dart';

class CbDiaryScreen extends Cubit<StDiaryScreen> {
  CbDiaryScreen() : super(const StDiaryScreen.init());
  TrainingModel training = TrainingModel(dateList: [], trainingList: []);
  DateTime currentDate = DateTime.now();
  String trainingTime = '';

  Future<void> getData(String dateTime, [bool loading = false]) async {
    try {
      loading ? emit(StDiaryScreen.loading()) : () {};

      training = await (getIt<TrainingRepository>().getTraining(dateTime));
      emit(StDiaryScreen.loaded(training));
    } on APIException catch (e) {
      emit(StDiaryScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  Future<void> addTraining(UserModel? selectedAthlete, String date, String time) async {
    try {
      emit(StDiaryScreen.loading());
      await (getIt<TrainingRepository>().addTraining(selectedAthlete, date, time));
      training = await (getIt<TrainingRepository>().getTraining(date));
      emit(StDiaryScreen.success(training));
    } on APIException catch (e) {
      emit(StDiaryScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}
