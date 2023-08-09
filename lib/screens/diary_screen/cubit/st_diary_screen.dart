part of 'cb_diary_screen.dart';

@freezed
abstract class StDiaryScreen with _$StDiaryScreen {
  const factory StDiaryScreen.loading() = _Loading;
  const factory StDiaryScreen.error(int? error, String? message) = _Error;
  const factory StDiaryScreen.loaded(TrainingModel training) = _Loaded;
  const factory StDiaryScreen.init() = _Init;
}