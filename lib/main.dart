import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Api.init(
      baseUrl:
          'https://your_api.com/api/v1/'); //Input your URL. Learn more eticon_api on pub.dev
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetCupertinoApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          home: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: const [
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.h1,
            ),
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.title,
            ),
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.bold,
            ),
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.regular,
            ),
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.medium,
            ),
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.tiny,
            ),
            PjText(
              text: "Ааааааааааа",
              style: PjTextStyle.downmenu,
            ),
          ],
        ),
      ),
    );
  }
}
