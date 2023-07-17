part of 'cb_athletes_screen.dart';

@freezed
abstract class StAthletesScreen with _$StAthletesScreen {
  const factory StAthletesScreen.loading() = _Loading;
  const factory StAthletesScreen.error(int? error, String? message) = _Error;
  const factory StAthletesScreen.loaded() = _Loaded;
}