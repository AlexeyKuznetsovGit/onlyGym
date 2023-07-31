part of 'cb_profile_screen.dart';

@freezed
abstract class StProfileScreen with _$StProfileScreen {
  const factory StProfileScreen.loading() = _Loading;
  const factory StProfileScreen.error(int? error, String? message) = _Error;
  const factory StProfileScreen.loaded(UserModel user) = _Loaded;
  const factory StProfileScreen.init() = _Init;
}