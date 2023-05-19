

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/error_alert.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_qr.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/screens/athlets_screen/widgets/avatar_card.dart';
import 'package:onlygym/screens/auth_screen/auth_screen_provider.dart';
import 'package:onlygym/screens/current_exercises_screen/widget/stats_card.dart';
import 'package:onlygym/screens/exercises_screen/widgets/exercise_card.dart';
import 'package:onlygym/screens/profile_screen/widgets/info_card.dart';
import 'package:onlygym/screens/profile_screen/widgets/size_info_card.dart';

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
            PjQR(),
            SizedBox(height: 40.h,),
            StatsCard.cardio(round: 1, count: 12),
            SizedBox(height: 40.h,),
            StatsCard.static(round: 1, time: 12, weight: 22,),
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
}
