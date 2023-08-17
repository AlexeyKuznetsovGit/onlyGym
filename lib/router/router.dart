import 'package:auto_route/auto_route.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/models/training_model.dart';
import 'package:onlygym/screens/athletes_screen/athletes_screen.dart';
import 'package:onlygym/screens/auth_screen/auth_screen.dart';
import 'package:onlygym/screens/diary_screen/diary_screen.dart';
import 'package:onlygym/screens/exercises_screen/exercises_screen.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';
import 'package:onlygym/screens/my_target_screen/my_target_screen.dart';
import 'package:onlygym/screens/profile_image_screen/profile_image_screen.dart';
import 'package:onlygym/screens/profile_screen/profile_screen.dart';
import 'package:onlygym/screens/recover_password_screen/recover_password_screen.dart';
import 'package:onlygym/screens/registration_screen/registration_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/Id_confirmation_screen/id_confirmation_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/birthday_screen/birthday_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/my_params_screen/my_params_screen.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/screens/training_screen/training_screen.dart';

import '../screens/create_new_athlete_screen/create_new_athlete_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Widget|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: Api.tokenIsEmpty),
        AutoRoute(page: RecoverPasswordRoute.page),
        AutoRoute(page: RegistrationRoute.page),
        AutoRoute(page: ProfileImageRoute.page),
        AutoRoute(page: BirthdayRoute.page),
        AutoRoute(page: MyParamsRoute.page),
        AutoRoute(page: MyTargetRoute.page),
        AutoRoute(page: CreateNewAthleteRoute.page),
        AutoRoute(page: IdConfirmationRoute.page),
        AutoRoute(page: MainRoute.page, initial: Api.tokenIsNotEmpty, children: [
          AutoRoute(page: DiaryRoute.page, maintainState: false),
          AutoRoute(page: ExercisesRoute.page),
          AutoRoute(page: AthletesRoute.page, maintainState: false),
          AutoRoute(page: ProfileRoute.page, initial: true)
        ]),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: AthletesRoute.page),
        AutoRoute(page: TrainingRoute.page)
      ];
}
