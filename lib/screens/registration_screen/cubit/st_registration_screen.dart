part of 'cb_registration_screen.dart';

@freezed
abstract class StRegistrationScreen with _$StRegistrationScreen {
  const factory StRegistrationScreen.loading() = _Loading;
  const factory StRegistrationScreen.error(int? error, String? message) = _Error;
  const factory StRegistrationScreen.loaded() = _Loaded;

}