import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/recover_password_screen/cubit/cb_recover_password_screen.dart';
import 'package:onlygym/screens/registration_screen/widgets/birthday_screen/cubit/cb_birthday_screen.dart';

@RoutePage()
class RecoverPasswordScreen extends StatefulWidget implements AutoRouteWrapper {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbRecoverPasswordScreen>(
      create: (context) => CbRecoverPasswordScreen(),
      child: this,
    );
  }
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
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
        child: BlocConsumer<CbRecoverPasswordScreen, StRecoverPasswordScreen>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                recoverSuccess: () {
                  context.router.pop();
                },
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
              "Забыли пароль?",
              style: PjTextStyle.h1,
              color: PjColors.neonBlue,
            ),
            SizedBox(
              height: 10.h,
            ),
            const PjText(
              "Мы отправим инструкции по восставлению\n\nпароля на вашу почту",
              align: TextAlign.center,
              style: PjTextStyle.regular,
            ),
            SizedBox(
              height: 50.h,
            ),
            Form(
                key: _formKey,
                child: PjTextField(type: PjTextFieldStyle.email, title: "Email", controller: emailController)),
            if (isPressed && _formKey.currentState != null && !_formKey.currentState!.validate())
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  emailController.text.isEmpty ? 'Пожалуйста, заполните поле' : 'Email указан неверно',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(
              height: 30.h,
            ),
            PjFilledButton(
                text: "Восстановить пароль",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<CbRecoverPasswordScreen>().recoverPassword(email: emailController.text);
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
