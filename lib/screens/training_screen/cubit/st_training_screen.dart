part of 'cb_training_screen.dart';

@freezed
abstract class StTrainingScreen with _$StTrainingScreen {
  const factory StTrainingScreen.loading() = _Loading;
  const factory StTrainingScreen.error(int? error, String? message) = _Error;
  const factory StTrainingScreen.loaded() = _Loaded;
  const factory StTrainingScreen.init() = _Init;
}