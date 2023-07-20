part of 'cb_auth_screen.dart';

@freezed
abstract class StAuthScreen with _$StAuthScreen {
  const factory StAuthScreen.loading() = _Loading;
  const factory StAuthScreen.error(int? error, String? message) = _Error;


  const factory StAuthScreen.signIn() = _SignIn;
  const factory StAuthScreen.signUp() = _SignUp;

  const factory StAuthScreen.signInSuccessful() = _SignInSuccessful;
  const factory StAuthScreen.signUpSuccessful() = _SignUpSuccessful;
}