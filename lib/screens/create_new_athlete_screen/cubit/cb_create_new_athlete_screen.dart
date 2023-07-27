import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_create_new_athlete_screen.dart';

part 'cb_create_new_athlete_screen.freezed.dart';

class CbCreateNewAthleteScreen extends Cubit<StCreateNewAthleteScreen> {
  CbCreateNewAthleteScreen() : super(StCreateNewAthleteScreen.loaded());

  Future<void> createNewAthlete() async {
  try {
      Map<String, dynamic> response =
          await Api.get('method', testMode: true);
      //emit(StCreateNewAthleteScreenLoaded());
    } on APIException catch (e) {
      //emit(StCreateNewAthleteScreenError(error: e.code));
    }
  }
}
    