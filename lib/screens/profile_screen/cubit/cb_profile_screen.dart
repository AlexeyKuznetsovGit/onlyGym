import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/athlete_repository.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';

part 'st_profile_screen.dart';

part 'cb_profile_screen.freezed.dart';

class CbProfileScreen extends Cubit<StProfileScreen> {
  CbProfileScreen() : super(const StProfileScreen.loaded());
  bool isSubmitted = false;

  Future<void> changeGoal({required String goal, int? athleteId}) async {
    try {
      emit(StProfileScreen.loading());
      await (getIt<AthleteRepository>().addGoal(goal: goal, athleteId: athleteId));
      UserModel user = await (getIt<UserRepository>().getMe());
      SgAppData.instance.user = user;
      emit(StProfileScreen.loaded());
    } on APIException catch (e) {
      emit(StProfileScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  Future<void> changeOneParam(
      {required int idParam, required String title, required double value, int? athleteId}) async {
    try {
      emit(StProfileScreen.loading());
      bool send = true;
      for (ParametersModel param in SgAppData.instance.user.parameters!) {
        if (param.name == title && param.value == value) {
          send = false;
        }
      }

      if (send) await (getIt<AthleteRepository>().addParams(paramId: idParam, value: value, athleteId: athleteId));
      UserModel user = await (getIt<UserRepository>().getMe());
      SgAppData.instance.user = user;
      emit(StProfileScreen.loaded());
    } on APIException catch (e) {
      emit(StProfileScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  Future<void> editProfile(
      {required String firstName,
      required String lastName,
      required String dateBirth,
      required double height,
      required double weight,
      int? athleteId}) async {
    try {
      emit(StProfileScreen.loading());
      await (getIt<AthleteRepository>().editAthlete(
          firstName: firstName, lastName: lastName, dateBirth: formatDateToISO(dateBirth), athleteId: athleteId));
      if (SgAppData.instance.user.parameters![0].value != height) {
        await (getIt<AthleteRepository>().addParams(paramId: 1, value: height, athleteId: athleteId));
      }
      if (SgAppData.instance.user.parameters![1].value != weight) {
        await (getIt<AthleteRepository>().addParams(paramId: 2, value: weight, athleteId: athleteId));
      }
      UserModel user = await (getIt<UserRepository>().getMe());
      SgAppData.instance.user = user;
      emit(StProfileScreen.loaded());
    } on APIException catch (e) {
      emit(StProfileScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  String getCurrentParameter(String title) {
    for (ParametersModel param in SgAppData.instance.user.parameters!) {
      if (param.name == title) {
        return param.value.toString();
      }
    }
    return '-';
  }
}

String formatDateToISO(String inputDate) {
  DateFormat inputDateFormat = DateFormat("dd.MM.yyyy");
  DateFormat outputDateFormat = DateFormat("yyyy-MM-dd");

  try {
    DateTime date = inputDateFormat.parseStrict(inputDate);
    String formattedDate = outputDateFormat.format(date);
    return formattedDate;
  } catch (e) {
    print('Ошибка при преобразовании даты: $e');
    return '';
  }
}
