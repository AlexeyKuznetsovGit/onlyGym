import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/auth_repository.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';

part 'st_registration_screen.dart';

part 'cb_registration_screen.freezed.dart';

class CbRegistrationScreen extends Cubit<StRegistrationScreen> {

  CbRegistrationScreen() : super(const StRegistrationScreen.loaded());

  Future<void> login({required String email, required String password}) async {
    try {


    } on APIException catch (e) {
      emit(StRegistrationScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}