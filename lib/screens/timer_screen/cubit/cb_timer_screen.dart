import 'st_timer_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbTimerScreen extends Cubit<StTimerScreen> {
  CbTimerScreen() : super(StTimerScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get( 'method', testMode: true);
      emit(StTimerScreenLoaded());
    } on APIException catch (e) {
      emit(StTimerScreenError(error: e.code));
    }
  }
}
    