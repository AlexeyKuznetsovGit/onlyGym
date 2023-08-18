part of 'cb_new_exercise_screen.dart';

@freezed
abstract class StNewExerciseScreen with _$StNewExerciseScreen {
  const factory StNewExerciseScreen.loading() = _Loading;
  const factory StNewExerciseScreen.error(int? error, String? message) = _Error;
  const factory StNewExerciseScreen.loaded() = _Loaded;
  const factory StNewExerciseScreen.init() = _Init;
}