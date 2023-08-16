import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'st_training_screen.dart';

part 'cb_training_screen.freezed.dart';

class CbTrainingScreen extends Cubit<StTrainingScreen> {

  CbTrainingScreen() : super(const StTrainingScreen.loaded());

}