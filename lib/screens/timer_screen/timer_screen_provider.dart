import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_screen.dart';
import 'cubit/cb_timer_screen.dart';
import 'cubit/st_timer_screen.dart';

class TimerScreenProvider extends StatelessWidget {
  const TimerScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbTimerScreen>(
      create: (context) => CbTimerScreen(),
      child: const TimerScreen(),
    );
  }
}    
    