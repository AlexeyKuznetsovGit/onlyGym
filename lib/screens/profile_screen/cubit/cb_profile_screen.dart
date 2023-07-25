import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_profile_screen.dart';

part 'cb_profile_screen.freezed.dart';

class CbProfileScreen extends Cubit<StProfileScreen> {

  CbProfileScreen() : super(const StProfileScreen.loaded());
  bool isSubmitted = false;
  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get( 'method', testMode: true);
      emit(StProfileScreen.loaded());
    } on APIException catch (e) {
      emit(StProfileScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}