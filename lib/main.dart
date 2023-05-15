import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_icon_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_unfilled_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Api.init(baseUrl: 'https://your_api.com/api/v1/'); //Input your URL. Learn more eticon_api on pub.dev
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
      child: Scr()
    );
  }
}

class Scr extends StatelessWidget {
  const Scr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: Center(child: PjLongButton(onPressed: (){}, icon: CustomIcons.edit, text: 'Edit Profile',),)
    );
  }
}
