part of 'cb_auth_screen.dart';

@freezed
abstract class StAuthScreen with _$StAuthScreen {
  const factory StAuthScreen.loading() = _Loading;
  const factory StAuthScreen.error(int? error, String? message) = _Error;
  const factory StAuthScreen.loaded() = _Loaded;
  const factory StAuthScreen.signInSuccessful() = _SignInSuccessful;
}