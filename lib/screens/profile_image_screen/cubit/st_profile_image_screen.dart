part of 'cb_profile_image_screen.dart';

@freezed
abstract class StProfileImageScreen with _$StProfileImageScreen {
  const factory StProfileImageScreen.loading() = _Loading;
  const factory StProfileImageScreen.error(int? error, String? message) = _Error;
  const factory StProfileImageScreen.loaded() = _Loaded;
  const factory StProfileImageScreen.addPhotoSuccess() = _AddPhotoSuccess;
}