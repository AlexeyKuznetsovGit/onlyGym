
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_timer_screen.dart';

part 'cb_timer_screen.freezed.dart';

class CbTimerScreen extends Cubit<StTimerScreen> {
  CbTimerScreen() : super(StTimerScreen.loaded());

  Future<void> getData() async {
    try {
      Map<String, dynamic> response = await Api.get('method', testMode: true);
      emit(StTimerScreen.loaded());
    } on APIException catch (e) {
      emit(StTimerScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }
}
