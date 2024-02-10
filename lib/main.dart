import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/repositories/athlete_repository.dart';
import 'package:onlygym/repositories/auth_repository.dart';
import 'package:onlygym/repositories/dictionary_repository.dart';
import 'package:onlygym/repositories/exercise_repository.dart';
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/training_repository.dart';
import 'package:onlygym/repositories/user_repository.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';

BuildContext? contextForGlobalError;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Api.init(
      urls: [
        'http://88.204.74.60:33333/v1/api/users',
        'http://88.204.74.60:33333/v1/auth',
        'http://88.204.74.60:33333/v1/api/athlete',
        'http://88.204.74.60:33333/v1/api/training',
        'http://88.204.74.60:33333/v1/api/exercise',
        'http://88.204.74.60:33333/v1/api/dictionary/'
      ],
      onAllError: (e) {
        if (e.code == 401 && contextForGlobalError != null) {
          AutoRouter.of(contextForGlobalError!).pushAndPopUntil(AuthRoute(), predicate: (e) => false);
        }
      });
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => AthleteRepository());
  getIt.registerLazySingleton(() => TrainingRepository());
  getIt.registerLazySingleton(() => ExerciseRepository());
  getIt.registerLazySingleton(() => DictionaryRepository());
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(390, 844),
      builder: (context, child) {
        return /*MaterialApp.router(
            routerConfig: _appRouter.config(),
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );*/
            GetCupertinoApp.router(
          routerDelegate: AutoRouterDelegate(_appRouter),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

class ApiUrls {
  static int users = 0;
  static int auth = 1;
  static int athlete = 2;
  static int training = 3;
  static int exercise = 4;
  static int dictionary = 5;
}

