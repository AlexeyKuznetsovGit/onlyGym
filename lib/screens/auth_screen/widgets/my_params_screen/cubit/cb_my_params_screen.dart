import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_my_params_screen.dart';

part 'cb_my_params_screen.freezed.dart';

class CbMyParamsScreen extends Cubit<StMyParamsScreen> {

  CbMyParamsScreen() : super(const StMyParamsScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get('method', testMode: true);
      emit(StMyParamsScreen.loaded());
    } on APIException catch (e) {
      emit(StMyParamsScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}