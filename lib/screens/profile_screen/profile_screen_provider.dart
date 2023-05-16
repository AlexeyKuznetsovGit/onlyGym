import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_screen.dart';
import 'cubit/cb_profile_screen.dart';
import 'cubit/st_profile_screen.dart';

class ProfileScreenProvider extends StatelessWidget {
  const ProfileScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CbProfileScreen>(
      create: (context) => CbProfileScreen(),
      child: const ProfileScreen(),
    );
  }
}    
    