import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_id_confirmation_screen.dart';

part 'cb_id_confirmation_screen.freezed.dart';

class CbIdConfirmationScreen extends Cubit<StIdConfirmationScreen> {

  CbIdConfirmationScreen() : super(const StIdConfirmationScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get(method: 'method', testMode: true);
      emit(StIdConfirmationScreen.loaded());
    } on APIException catch (e) {
      emit(StIdConfirmationScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}