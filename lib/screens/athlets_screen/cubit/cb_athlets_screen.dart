import 'st_athlets_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbAthletsScreen extends Cubit<StAthletsScreen> {
  CbAthletsScreen() : super(StAthletsScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StAthletsScreenLoaded());
    } on APIException catch (e) {
      emit(StAthletsScreenError(error: e.code));
    }
  }
}
    