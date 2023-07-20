import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/screens/Id_confirmation_screen/id_confirmation_screen.dart';
import 'package:onlygym/screens/athletes_screen/athletes_screen.dart';
import 'package:onlygym/screens/auth_screen/auth_screen.dart';
import 'package:onlygym/screens/diary_screen/diary_screen.dart';
import 'package:onlygym/screens/exercises_screen/exercises_screen.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';
import 'package:onlygym/screens/profile_image_screen/profile_image_screen.dart';
import 'package:onlygym/screens/profile_screen/profile_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Widget|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(page: IdConfirmationRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: DiaryRoute.page),
          AutoRoute(page: ExercisesRoute.page),
          AutoRoute(page: AthletesRoute.page),
          AutoRoute(page: ProfileRoute.page)
        ]),
        AutoRoute(page: ProfileImageRoute.page)
      ];
}
