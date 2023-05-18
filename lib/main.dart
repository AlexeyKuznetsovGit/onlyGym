import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/screens/athlets_screen/widgets/avatar_card.dart';
import 'package:onlygym/screens/exercises_screen/widgets/exercise_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Api.init(
      baseUrl:
          'https://your_api.com/api/v1/'); //Input your URL. Learn more eticon_api on pub.dev
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return GetCupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            home: child,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
        child: Scr());
  }
}

class Scr extends StatefulWidget {
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
            AvatarCard(
              callback: () {
              },
            ),
            SizedBox(height: 50.h,),
            ExerciseCard(callback: (){}),
            SizedBox(height: 50.h,),
            ExerciseCard.delete(callback: (){}, deleteCallback: (){}),
            SizedBox(height: 50.h,),
            ExerciseCard.chekbox(callback: (){}),
            SizedBox(height: 50.h,),
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
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(CustomIcons.diary), label: "Дневник"),
          BottomNavigationBarItem(icon: Icon(CustomIcons.exercises), label: "Упражнения"),
          BottomNavigationBarItem(icon: Icon(CustomIcons.athletes), label: "Атлеты"),
          BottomNavigationBarItem(icon: Icon(CustomIcons.profile), label: "Профиль"),
        ],
      ),
    );
  }
}
