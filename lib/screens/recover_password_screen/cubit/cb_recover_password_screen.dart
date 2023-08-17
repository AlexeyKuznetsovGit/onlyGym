import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/repositories/auth_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_recover_password_screen.dart';

part 'cb_recover_password_screen.freezed.dart';

class CbRecoverPasswordScreen extends Cubit<StRecoverPasswordScreen> {

  CbRecoverPasswordScreen() : super(const StRecoverPasswordScreen.loaded());

  Future<void> recoverPassword({required String email}) async {
    try {
      emit(StRecoverPasswordScreen.loading());
      await (getIt<AuthRepository>().recoverPassword(email: email));
      emit(StRecoverPasswordScreen.recoverSuccess());
    } on APIException catch (e) {
      emit(StRecoverPasswordScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}