import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/screens/athletes_screen/athletes_screen.dart';
import 'package:onlygym/screens/auth_screen/auth_screen.dart';
import 'package:onlygym/screens/auth_screen/widgets/Id_confirmation_screen/id_confirmation_screen.dart';
import 'package:onlygym/screens/auth_screen/widgets/birthday_screen/birthday_screen.dart';
import 'package:onlygym/screens/auth_screen/widgets/my_params_screen/my_params_screen.dart';
import 'package:onlygym/screens/diary_screen/diary_screen.dart';
import 'package:onlygym/screens/exercises_screen/exercises_screen.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';
import 'package:onlygym/screens/my_target_screen/my_target_screen.dart';
import 'package:onlygym/screens/profile_image_screen/profile_image_screen.dart';
import 'package:onlygym/screens/profile_screen/profile_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Widget|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(page: ProfileImageRoute.page),
        AutoRoute(page: BirthdayRoute.page),
        AutoRoute(page: MyParamsRoute.page),
        AutoRoute(page: MyTargetRoute.page),
        AutoRoute(page: IdConfirmationRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: DiaryRoute.page),
          AutoRoute(page: ExercisesRoute.page),
          AutoRoute(page: AthletesRoute.page),
          AutoRoute(page: ProfileRoute.page)
        ]),
      ];
}
