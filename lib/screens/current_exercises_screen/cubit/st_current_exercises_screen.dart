part of 'cb_current_exercises_screen.dart';

@freezed
abstract class StCurrentExercisesScreen with _$StCurrentExercisesScreen {
  const factory StCurrentExercisesScreen.loading() = _Loading;
  const factory StCurrentExercisesScreen.error(int? error, String? message) = _Error;
  const factory StCurrentExercisesScreen.loaded() = _Loaded;
  const factory StCurrentExercisesScreen.init() = _Init;
}