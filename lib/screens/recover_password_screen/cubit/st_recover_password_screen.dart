part of 'cb_recover_password_screen.dart';

@freezed
abstract class StRecoverPasswordScreen with _$StRecoverPasswordScreen {
  const factory StRecoverPasswordScreen.loading() = _Loading;
  const factory StRecoverPasswordScreen.error(int? error, String? message) = _Error;
  const factory StRecoverPasswordScreen.loaded() = _Loaded;
  const factory StRecoverPasswordScreen.recoverSuccess() = _RecoverSuccess;
}