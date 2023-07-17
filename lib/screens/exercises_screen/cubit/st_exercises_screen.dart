part of 'cb_exercises_screen.dart';

@freezed
abstract class StExercisesScreen with _$StExercisesScreen {
  const factory StExercisesScreen.loading() = _Loading;
  const factory StExercisesScreen.error(int? error, String? message) = _Error;
  const factory StExercisesScreen.loaded() = _Loaded;
}