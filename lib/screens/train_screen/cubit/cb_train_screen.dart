import 'st_train_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbTrainScreen extends Cubit<StTrainScreen> {
  CbTrainScreen() : super(StTrainScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StTrainScreenLoaded());
    } on APIException catch (e) {
      emit(StTrainScreenError(error: e.code));
    }
  }
}
    