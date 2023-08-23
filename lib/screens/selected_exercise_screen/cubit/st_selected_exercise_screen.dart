part of 'cb_selected_exercise_screen.dart';

@freezed
abstract class StSelectedExerciseScreen with _$StSelectedExerciseScreen {
  const factory StSelectedExerciseScreen.loading() = _Loading;
  const factory StSelectedExerciseScreen.error(int? error, String? message) = _Error;
  const factory StSelectedExerciseScreen.loaded() = _Loaded;
  const factory StSelectedExerciseScreen.init() = _Init;
}