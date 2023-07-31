import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/registration_screen/widgets/birthday_screen/cubit/cb_birthday_screen.dart';

@RoutePage()
class BirthdayScreen extends StatefulWidget implements AutoRouteWrapper {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbBirthdayScreen>(
      create: (context) => CbBirthdayScreen(),
      child: this,
    );
  }
}

class _BirthdayScreenState extends State<BirthdayScreen> {

  final _formKeyBirthday = GlobalKey<FormState>();
  TextEditingController birthdayController = TextEditingController();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 48.h,
        margin: EdgeInsets.only(bottom: 20.h),
        alignment: Alignment.center,
        child: PjTextButton(
          textColor: PjColors.neonBlue,
          textStyle: PjTextStyle.tiny,
          text: "Политика конфиденциальности и Правила использования",
          type: PjTextButtonType.left,
          onPressed: () {},
        ),
      ),
      appBar: PjAppBar(
        leading: () {
          context.router.pop();
        },
      ),
      backgroundColor: PjColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<CbBirthdayScreen, StBirthdayScreen>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                error: (code, message) {
                  showAlertDialog(context, message!);
                });
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => _buildBodyContent(context),
            loading: () => const PjLoader(),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            const PjText(
              "Дата рождения",
              style: PjTextStyle.h1,
              color: PjColors.neonBlue,
            ),
            SizedBox(
              height: 10.h,
            ),
            const PjText(
              "Введите дату своего рождения",
              align: TextAlign.center,
              style: PjTextStyle.regular,
            ),
            SizedBox(
              height: 50.h,
            ),
            Form(
                key: _formKeyBirthday,
                child: PjTextField(type: PjTextFieldStyle.date,title: "Дата рождения", controller: birthdayController)),
            if (isPressed &&
                _formKeyBirthday.currentState != null &&
                !_formKeyBirthday.currentState!.validate())
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  birthdayController.text.isEmpty ? 'Пожалуйста, заполните поле' : 'Введена некорректная дата',
                  style: TextStyle(color: Colors.red),
                ),
              ),

            SizedBox(
              height: 30.h,
            ),
            PjFilledButton(
                text: "Продолжить",
                onPressed: () {
                  if (_formKeyBirthday.currentState!.validate()) {
                    SgAppData.instance.user.dateBirth = formatDateToISO(birthdayController.text);
                    print(SgAppData.instance.user.dateBirth);
                    context.router.push(MyParamsRoute());
                  } else {
                    setState(() {
                      isPressed = true;
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
