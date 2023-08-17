import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/models/photos_model.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/athlete_repository.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';

part 'st_profile_image_screen.dart';

part 'cb_profile_image_screen.freezed.dart';

class CbProfileImageScreen extends Cubit<StProfileImageScreen> {
  CbProfileImageScreen() : super(const StProfileImageScreen.loaded());

  Future<void> addAvatar({required String image}) async {
    try {
      emit(StProfileImageScreen.loading());

      if (!image.contains("http")) {
        await (getIt<AthleteRepository>().addPhoto(pathPhoto: image, namePhoto: image.split('/').last));
      }

      UserModel user = await (getIt<UserRepository>().getMe());
      SgAppData.instance.user = user;
      if (GetStorage().read('localAvatar') == null) {
        if (user.photos!.isNotEmpty) {
          for (PhotosModel photo in user.photos!) {
            if (photo.isAvatar!) {
              SgAppData.instance.avatar = "${PjUtils.imageUrl}${photo.url}";
            }
          }
        } else {
          SgAppData.instance.localAvatar = CustomIcons.avatar;
        }
      } else {
        String codePoint = GetStorage().read('localAvatar');
        SgAppData.instance.localAvatar =
            IconData(int.parse(codePoint, radix: 16), fontFamily: 'CustomIcons', fontPackage: null);
      }
      emit(StProfileImageScreen.addPhotoSuccess());
    } on APIException catch (e) {
      emit(StProfileImageScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}
