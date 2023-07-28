import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/models/photos_model.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';

part 'st_main_screen.dart';

part 'cb_main_screen.freezed.dart';

class CbMainScreen extends Cubit<StMainScreen> {
  CbMainScreen() : super(const StMainScreen.loading());

  Future<void> getData() async {
    try {
      UserModel user = await (getIt<UserRepository>().getMe());
      SgAppData.instance.user = user;
      if (user.photos!.isNotEmpty) {
        for (PhotosModel photo in user.photos!) {
          if (photo.isAvatar!) {
             SgAppData.instance.avatar = "${PjUtils.imageUrl}${photo.url}";

          }
        }
      } else {
        SgAppData.instance.localAvatar = CustomIcons.avatar;
      }
      if (GetStorage().read('localAvatar') != null) {
        String codePoint = GetStorage().read('localAvatar');
        SgAppData.instance.localAvatar =
            IconData(int.parse(codePoint, radix: 16), fontFamily: 'CustomIcons', fontPackage: null);
      }
      /* if (GetStorage().read('localAvatar') == null) {
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
      }*/
      emit(StMainScreen.loaded(user));
    } on APIException catch (e) {
      emit(StMainScreen.error(e.code, e.body.toString()));
    }
  }
}
