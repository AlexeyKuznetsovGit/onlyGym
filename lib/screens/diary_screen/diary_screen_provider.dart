import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'diary_screen.dart';
import 'cubit/cb_diary_screen.dart';
import 'cubit/st_diary_screen.dart';

class DiaryScreenProvider extends StatelessWidget {
  const DiaryScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbDiaryScreen>(
      create: (context) => CbDiaryScreen(),
      child: const DiaryScreen(),
    );
  }
}    
    