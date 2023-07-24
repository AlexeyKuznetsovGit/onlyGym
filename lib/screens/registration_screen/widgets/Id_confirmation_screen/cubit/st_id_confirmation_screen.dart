part of 'cb_id_confirmation_screen.dart';

@freezed
abstract class StIdConfirmationScreen with _$StIdConfirmationScreen {
  const factory StIdConfirmationScreen.loading() = _Loading;
  const factory StIdConfirmationScreen.error(int? error, String? message) = _Error;
  const factory StIdConfirmationScreen.loaded(int? code) = _Loaded;
  const factory StIdConfirmationScreen.signUpSuccessful() = _SignUpSuccessful;
}