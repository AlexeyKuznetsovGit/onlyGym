import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/auth_repository.dart';
import 'package:onlygym/repositories/user_repository.dart';

import '../../../../../repositories/get_it.dart';

part 'st_id_confirmation_screen.dart';

part 'cb_id_confirmation_screen.freezed.dart';

class CbIdConfirmationScreen extends Cubit<StIdConfirmationScreen> {
  CbIdConfirmationScreen() : super(const StIdConfirmationScreen.loading());

  Future<void> registration(
      {bool loading = false,
      required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String dateBirthday,
      required double height,
      required double weight,
      required String target,
      String? pathPhoto,
      String? namePhoto}) async {
    try {
      int code = await (getIt<AuthRepository>().registration(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          dateBirthday: dateBirthday,
          height: height,
          weight: weight,
          target: target,
          pathPhoto: pathPhoto,
          namePhoto: namePhoto));
      log(code.toString(), name: 'CheckCode');
      emit(StIdConfirmationScreen.loaded(code));
    } on APIException catch (e) {
      log('ADASDASD', name: 'ERROR');

      emit(StIdConfirmationScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  Future<void> finishRegistration() async {
    try {
      emit(StIdConfirmationScreen.loading());
      await (getIt<AuthRepository>()
          .login(email: SgAppData.instance.user.email!, password: SgAppData.instance.password!));
      if (Api.tokenIsNotEmpty) {
        UserModel user = await (getIt<UserRepository>().getMe());
        SgAppData.instance.user = user;
        log(SgAppData.instance.user.toString(), name: 'UserSignUp');
      }
      emit(StIdConfirmationScreen.signUpSuccessful());
    } on APIException catch (e) {
      emit(StIdConfirmationScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}
