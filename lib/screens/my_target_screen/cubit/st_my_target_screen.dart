part of 'cb_my_target_screen.dart';

@freezed
abstract class StMyTargetScreen with _$StMyTargetScreen {
  const factory StMyTargetScreen.loading() = _Loading;
  const factory StMyTargetScreen.error(int? error, String? message) = _Error;
  const factory StMyTargetScreen.loaded() = _Loaded;
}