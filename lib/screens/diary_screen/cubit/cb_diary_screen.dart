import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_diary_screen.dart';

part 'cb_diary_screen.freezed.dart';

class CbDiaryScreen extends Cubit<StDiaryScreen> {

  CbDiaryScreen() : super(const StDiaryScreen.loaded());

  Future<void> getData() async {
    try {
      /*Map<String, dynamic> response =
      await Api.get(method: 'method', testMode: true);*/
      emit(const StDiaryScreen.loaded());
    } on APIException catch (e) {
      emit(StDiaryScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}