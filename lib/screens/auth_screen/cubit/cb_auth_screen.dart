import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/auth_repository.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';

part 'st_auth_screen.dart';

part 'cb_auth_screen.freezed.dart';

class CbAuthScreen extends Cubit<StAuthScreen> {

  CbAuthScreen() : super(const StAuthScreen.loaded());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(StAuthScreen.loading());
      await (getIt<AuthRepository>().login(email: email, password: password));
      if(Api.tokenIsNotEmpty){
        UserModel user = await (getIt<UserRepository>().getMe());
        SgAppData.instance.user = user;
        log(SgAppData.instance.user.toString(),name: 'UserLogin');
      }
      emit(StAuthScreen.signInSuccessful());
    } on APIException catch (e) {
      String textError = "Что-то пошло не так!";
      if (e.body['detail'] != null) {
        if (e.body['detail'] == 'User not found or incorrect password') {
          textError = 'Неправильный логин/пароль';
        }
      }
      emit(StAuthScreen.error(e.code, textError));
    }
  }
}