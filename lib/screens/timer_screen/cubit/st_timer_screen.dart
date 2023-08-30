part of 'cb_timer_screen.dart';

@freezed
abstract class StTimerScreen with _$StTimerScreen {
  const factory StTimerScreen.loading() = _Loading;
  const factory StTimerScreen.error(int? error, String? message) = _Error;
  const factory StTimerScreen.loaded() = _Loaded;
  const factory StTimerScreen.init() = _Init;
}