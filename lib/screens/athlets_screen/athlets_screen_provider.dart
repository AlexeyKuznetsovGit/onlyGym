import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'athlets_screen.dart';
import 'cubit/cb_athlets_screen.dart';
import 'cubit/st_athlets_screen.dart';

class AthletsScreenProvider extends StatelessWidget {
  const AthletsScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbAthletsScreen>(
      create: (context) => CbAthletsScreen(),
      child: const AthletsScreen(),
    );
  }
}    
    