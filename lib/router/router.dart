import 'package:auto_route/auto_route.dart';
import 'package:onlygym/screens/athletes_screen/athletes_screen.dart';
import 'package:onlygym/screens/diary_screen/diary_screen.dart';
import 'package:onlygym/screens/exercises_screen/exercises_screen.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';
import 'package:onlygym/screens/profile_screen/profile_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Widget|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true, children: [
          AutoRoute(page: DiaryRoute.page),
          AutoRoute(page: ExercisesRoute.page),
          AutoRoute(page: AthletesRoute.page),
          AutoRoute(page: ProfileRoute.page)
        ])
      ];
}
