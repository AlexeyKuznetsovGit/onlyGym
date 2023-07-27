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
import 'package:onlygym/repositories/get_it.dart';
import 'package:onlygym/repositories/user_repository.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/main_screen/main_screen.dart';

BuildContext? contextForGlobalError;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Api.init(urls: ['http://88.204.74.60:33333/v1/api/users', 'http://88.204.74.60:33333/v1/auth', 'http://88.204.74.60:33333/v1/api/athlete'], onAllError: (e){
    if(e.code == 401 && contextForGlobalError != null){
      AutoRouter.of(contextForGlobalError!).pushAndPopUntil(AuthRoute(), predicate: (e)=>false);
    }
  });
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => AthleteRepository());
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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

class ApiUrls{
  static int users = 0;
  static int auth = 1;
  static int athlete = 2;
}

/*class Scr extends StatefulWidget {
  const Scr({Key? key}) : super(key: key);

  @override
  State<Scr> createState() => _ScrState();
}

class _ScrState extends State<Scr> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(),
      body: Center(
        child: Column(
          children: [
            // SizeInfoCard(
            //   callback: () {},
            //   title: "Шея",
            //   icon: CustomIcons.left_shoulder,
            //   data: 144.toString(),
            // ),
            // SizedBox(height: 40.h),
            // SizeInfoCard(
            //   callback: () {},
            //   title: "Правое плечо",
            //   icon: CustomIcons.left_shoulder,
            //   isLong: true,
            //   data: 144.toString(),
            // ),
            // SizedBox(height: 40.h),
            // InfoCard(callback: (){
            //   Get.dialog(ErrorAlert(text: 'Пользователь с таким адресом уже существует',),  barrierDismissible: true);
            // }, title: "Возраст", data: "21"),
            SizedBox(height: 40.h),
            ExerciseCard(callback: (){}),
            SizedBox(height: 40.h,),
            CurrentExerciseCard(title: "Гиперэкстензия", type: "Динамика", callback: (){},),
            SizedBox(height: 40.h,),
            StatsCard.dynamic(round: 1, count: 22, weight: 34),
            SizedBox(height: 40.h,),
            StatsCard.statdyn(round: 1, count: 33, weight: 23, time: 88)


            //
            // AvatarCard(
            //   callback: () {
            //   },
            // ),
            // SizedBox(height: 50.h,),
            // PjTextField(title: 'Email', controller: TextEditingController(),),
            // SizedBox(height: 50.h,),
            // PjTextField(title: 'Password', controller: TextEditingController(), isPassword: true,),
            // ExerciseCard(callback: (){}),
            // SizedBox(height: 50.h,),
            // ExerciseCard.delete(callback: (){}, deleteCallback: (){}),
            // SizedBox(height: 50.h,),
            // ExerciseCard.chekbox(callback: (){}),
            // SizedBox(height: 50.h,),
          ],
        ),
      ),
      // @todo Убрать свечение
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: PjColors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PjColors.neonBlue,
        unselectedItemColor: PjColors.gray,
        selectedFontSize: 10.w,
        unselectedFontSize: 10.w,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(fontFamily: "SFPro"),
        unselectedLabelStyle: const TextStyle(fontFamily: "SFPro"),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.diary), label: "Дневник"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.exercises), label: "Упражнения"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.athletes), label: "Атлеты"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.profile), label: "Профиль"),
        ],
      ),
    );
  }
}*/
