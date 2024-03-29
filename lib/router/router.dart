import 'package:auto_route/auto_route.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/models/training_model.dart';
import 'package:onlygym/screens/athletes_screen/athletes_screen.dart';
import 'package:onlygym/screens/auth_screen/auth_screen.dart';
import 'package:onlygym/screens/current_exercises_screen/current_exercises_screen.dart';
import 'package:onlygym/screens/diary_screen/diary_screen.dart';
import 'package:onlygym/screens/exercises_screen/exercises_screen.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';
import 'package:onlygym/screens/my_target_screen/my_target_screen.dart';
import 'package:onlygym/screens/new_exercise_screen/new_exercise_screen.dart';
import 'package:onlygym/screens/profile_image_screen/profile_image_screen.dart';
import 'package:onlygym/screens/profile_screen/profile_screen.dart';
import 'package:onlygym/screens/recover_password_screen/recover_password_screen.dart';
import 'package:onlygym/screens/registration_screen/registration_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/Id_confirmation_screen/id_confirmation_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/birthday_screen/birthday_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/my_params_screen/my_params_screen.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/screens/selected_exercise_screen/selected_exerice_screen.dart';
import 'package:onlygym/screens/timer_screen/timer_screen.dart';
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
        AutoRoute(path: '/', page: MainRoute.page, initial: Api.tokenIsNotEmpty, children: [
          AutoRoute(page: DiaryTab.page,maintainState: false,children: [
            AutoRoute(page: DiaryRoute.page, initial: true),
            AutoRoute(page: AthletesRoute.page),
            AutoRoute(page: TrainingRoute.page),
            AutoRoute(page: ExercisesRoute.page),
            AutoRoute(page: CurrentExercisesRoute.page),
            AutoRoute(page: TimerRoute.page),
          ]),
          AutoRoute(page: ExercisesTab.page, children: [
            AutoRoute(page: ExercisesRoute.page, initial: true),
            AutoRoute(page: CurrentExercisesRoute.page),
            AutoRoute(page: NewExerciseRoute.page, maintainState: false),
            AutoRoute(page: SelectedExerciseRoute.page,  maintainState: false),
          ]),
          AutoRoute( page: AthletesTab.page, children: [
            AutoRoute(page: AthletesRoute.page, path: '', maintainState: false),
            AutoRoute(page: ProfileRoute.page, path: 'athlete-profile',)
          ]),
          AutoRoute(path: 'profile', page: ProfileTab.page, initial: true, children: [
            AutoRoute(page: ProfileRoute.page, path: '',),
            AutoRoute(page: ProfileImageRoute.page, path: 'profile-image', maintainState: false),
          ])
        ]),
      ];
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}

@RoutePage(name: 'AthletesTab')
class AthletesTabPage extends AutoRouter {
  const AthletesTabPage({super.key});
}

@RoutePage(name: 'ExercisesTab')
class ExercisesTabPage extends AutoRouter {
  const ExercisesTabPage({super.key});
}

@RoutePage(name: 'DiaryTab')
class DiaryTabPage extends AutoRouter {
  const DiaryTabPage({super.key});
}
