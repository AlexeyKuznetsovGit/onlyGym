import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_auth_screen.dart';

part 'cb_auth_screen.freezed.dart';

class CbAuthScreen extends Cubit<StAuthScreen> {

  CbAuthScreen() : super(const StAuthScreen.signIn());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get('method', testMode: true);
      //emit(StAuthScreen.loaded());
    } on APIException catch (e) {
      emit(StAuthScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}