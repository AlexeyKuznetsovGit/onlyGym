part of 'cb_birthday_screen.dart';

@freezed
abstract class StBirthdayScreen with _$StBirthdayScreen {
  const factory StBirthdayScreen.loading() = _Loading;
  const factory StBirthdayScreen.error(int? error, String? message) = _Error;
  const factory StBirthdayScreen.loaded() = _Loaded;
}