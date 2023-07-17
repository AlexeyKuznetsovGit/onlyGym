import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_athletes_screen.dart';

part 'cb_athletes_screen.freezed.dart';

class CbAthletesScreen extends Cubit<StAthletesScreen> {

  CbAthletesScreen() : super(const StAthletesScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get(method: 'method', testMode: true);
      emit(StAthletesScreen.loaded());
    } on APIException catch (e) {
      emit(StAthletesScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}