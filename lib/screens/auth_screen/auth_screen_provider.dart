import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_screen.dart';
import 'cubit/cb_auth_screen.dart';
import 'cubit/st_auth_screen.dart';

class AuthScreenProvider extends StatelessWidget {
  const AuthScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbAuthScreen>(
      create: (context) => CbAuthScreen(),
      child: const AuthScreen(),
    );
  }
}    
    