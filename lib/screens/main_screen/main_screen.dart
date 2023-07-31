import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/main_screen/cubit/cb_main_screen.dart';

@RoutePage()
class MainScreen extends StatefulWidget implements AutoRouteWrapper {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbMainScreen>(
      create: (context) => CbMainScreen()..getData(),
      child: this,
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    contextForGlobalError = context;
    return BlocBuilder<CbMainScreen, StMainScreen>(
        builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            loading: () => Scaffold(body: PjLoader()),
            loaded: (user) => AutoTabsScaffold(
                routes: const [DiaryRoute(), ExercisesRoute(), AthletesRoute(), ProfileRoute()],
                lazyLoad: true,
                bottomNavigationBuilder: (_, tabsRouter) {
                  return BottomNavigationBar(
                    backgroundColor: PjColors.white,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: PjColors.neonBlue,
                    unselectedItemColor: PjColors.gray,
                    selectedFontSize: 10.w,
                    unselectedFontSize: 10.w,
                    showUnselectedLabels: true,
                    currentIndex: tabsRouter.activeIndex ,
                    selectedLabelStyle: const TextStyle(fontFamily: "SFPro"),
                    unselectedLabelStyle: const TextStyle(fontFamily: "SFPro"),
                    onTap: tabsRouter.setActiveIndex,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(CustomIcons.diary), label: "Дневник"),
                      BottomNavigationBarItem(icon: Icon(CustomIcons.exercises), label: "Упражнения"),
                      BottomNavigationBarItem(icon: Icon(CustomIcons.athletes), label: "Атлеты"),
                      BottomNavigationBarItem(icon: Icon(CustomIcons.profile), label: "Профиль"),
                    ],
                  );
                },
            )));
  }
}
