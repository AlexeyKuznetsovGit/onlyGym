import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_profile_image_screen.dart';

part 'cb_profile_image_screen.freezed.dart';

class CbProfileImageScreen extends Cubit<StProfileImageScreen> {

  CbProfileImageScreen() : super(const StProfileImageScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get( 'method', testMode: true);
      /*await photoRepository.sendPhoto(name: photo.split('/').last, imagePath: photo);*/
      emit(StProfileImageScreen.loaded());
    } on APIException catch (e) {
      emit(StProfileImageScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}