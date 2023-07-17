import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/router/router.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 /* @override
  Widget build(BuildContext context) {
    return BlocProvider<CbMainScreen>(
      create: (context) => CbMainScreen(),
      child: const MainScreen(),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        routes: const [
          DiaryRoute(),
          ExercisesRoute(),
          AthletesRoute(),
          ProfileRoute()
        ],
      bottomNavigationBuilder: (_, tabsRouter){return BottomNavigationBar(
        backgroundColor: PjColors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PjColors.neonBlue,
        unselectedItemColor: PjColors.gray,
        selectedFontSize: 10.w,
        unselectedFontSize: 10.w,
        showUnselectedLabels: true,
        currentIndex: tabsRouter.activeIndex,
        selectedLabelStyle: const TextStyle(fontFamily: "SFPro"),
        unselectedLabelStyle: const TextStyle(fontFamily: "SFPro"),
        onTap: tabsRouter.setActiveIndex,
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
      );}
    );

  }
}
    