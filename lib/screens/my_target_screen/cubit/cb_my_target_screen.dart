import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/repositories/athlete_repository.dart';
import 'package:onlygym/repositories/get_it.dart';

part 'st_my_target_screen.dart';

part 'cb_my_target_screen.freezed.dart';

class CbMyTargetScreen extends Cubit<StMyTargetScreen> {

  CbMyTargetScreen() : super(const StMyTargetScreen.loaded());
  bool isSubmitted = false;
  String selectedOption = 'Улучшение формы';
  Future<void> getData() async {
    try {
      Map<String, dynamic> response =
      await Api.get('method', testMode: true);
      emit(StMyTargetScreen.loaded());
    } on APIException catch (e) {
      emit(StMyTargetScreen.error(e.code, 'Что-то пошло не так!'));
    }
  }

  Future<void> createNewAthlete(UserModel user) async{
    try{
      emit(StMyTargetScreen.loading());
      await (getIt<AthleteRepository>().addNew(user));
    } catch(e){
      emit(StMyTargetScreen.error(400, 'Что-то пошло не так!'));
    }
  }
}