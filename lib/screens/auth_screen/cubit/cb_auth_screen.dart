import 'st_auth_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbAuthScreen extends Cubit<StAuthScreen> {
  CbAuthScreen() : super(StAuthScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StAuthScreenLoaded());
    } on APIException catch (e) {
      emit(StAuthScreenError(error: e.code));
    }
  }
}
    