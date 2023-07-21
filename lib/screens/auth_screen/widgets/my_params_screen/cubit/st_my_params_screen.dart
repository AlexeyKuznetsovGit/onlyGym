part of 'cb_my_params_screen.dart';

@freezed
abstract class StMyParamsScreen with _$StMyParamsScreen {
  const factory StMyParamsScreen.loading() = _Loading;
  const factory StMyParamsScreen.error(int? error, String? message) = _Error;
  const factory StMyParamsScreen.loaded() = _Loaded;
}