part of 'cb_create_new_athlete_screen.dart';

@freezed
abstract class StCreateNewAthleteScreen with _$StCreateNewAthleteScreen {
  const factory StCreateNewAthleteScreen.loading() = _Loading;
  const factory StCreateNewAthleteScreen.error(int? error, String? message) = _Error;
  const factory StCreateNewAthleteScreen.loaded() = _Loaded;
}