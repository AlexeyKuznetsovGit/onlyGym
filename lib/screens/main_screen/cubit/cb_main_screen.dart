import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';

part 'st_main_screen.dart';

part 'cb_main_screen.freezed.dart';

class CbMainScreen extends Cubit<StMainScreen> {
  CbMainScreen() : super(const StMainScreen.loading());

  Future<void> getData() async {
    try {
      UserModel user = await (getIt<UserRepository>().getMe());
      SgAppData.instance.user = user;
      emit(StMainScreen.loaded(user));
    } on APIException catch (e) {
      emit(StMainScreen.error(e.code, e.body.toString()));
    }
  }
}
