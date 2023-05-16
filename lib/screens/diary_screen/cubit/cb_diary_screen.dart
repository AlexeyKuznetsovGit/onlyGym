import 'st_diary_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbDiaryScreen extends Cubit<StDiaryScreen> {
  CbDiaryScreen() : super(StDiaryScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StDiaryScreenLoaded());
    } on APIException catch (e) {
      emit(StDiaryScreenError(error: e.code));
    }
  }
}
    