import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'train_screen.dart';
import 'cubit/cb_train_screen.dart';
import 'cubit/st_train_screen.dart';

class TrainScreenProvider extends StatelessWidget {
  const TrainScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbTrainScreen>(
      create: (context) => CbTrainScreen(),
      child: const TrainScreen(),
    );
  }
}    
    