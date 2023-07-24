import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_birthday_screen.dart';

part 'cb_birthday_screen.freezed.dart';

class CbBirthdayScreen extends Cubit<StBirthdayScreen> {

  CbBirthdayScreen() : super(const StBirthdayScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get('method', testMode: true);
      emit(StBirthdayScreen.loaded());
    } on APIException catch (e) {
      emit(StBirthdayScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}