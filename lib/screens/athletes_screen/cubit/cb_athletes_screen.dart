import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/repositories/athlete_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_athletes_screen.dart';

part 'cb_athletes_screen.freezed.dart';

class CbAthletesScreen extends Cubit<StAthletesScreen> {

  CbAthletesScreen() : super(const StAthletesScreen.loading());
  List<UserModel> list = [];
  Future<void> getData() async {
    try {
      list = [];
      list = await (getIt<AthleteRepository>().getAll());
      emit(StAthletesScreen.loaded(list));
    } on APIException catch (e) {
      emit(StAthletesScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
  Future<void> addAthleteByQr(int athleteId) async {
    try {
      emit(StAthletesScreen.loading());
      await (getIt<AthleteRepository>().addAthleteByQr(athleteId));
      List<UserModel> list = await (getIt<AthleteRepository>().getAll());
      emit(StAthletesScreen.loaded(list));
    } on APIException catch (e) {
      emit(StAthletesScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}