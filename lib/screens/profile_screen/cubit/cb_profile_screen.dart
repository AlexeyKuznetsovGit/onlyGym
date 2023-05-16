import 'st_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';

class CbProfileScreen extends Cubit<StProfileScreen> {
  CbProfileScreen() : super(StProfileScreenLoading());
  
  Future<void> getData() async {
  try {
      Map<String, dynamic> response =
          await Api.get(method: 'method', testMode: true);
      emit(StProfileScreenLoaded());
    } on APIException catch (e) {
      emit(StProfileScreenError(error: e.code));
    }
  }
}
    