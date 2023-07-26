import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'cubit/cb_auth_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthScreen extends StatefulWidget implements AutoRouteWrapper {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbAuthScreen>(
      create: (context) => CbAuthScreen(),
      child: this,
    );
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKeySignIn = GlobalKey<FormState>();

  bool isPressed = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // @todo Доработать недостающие виджеты
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
      appBar: PjAppBar(),
      backgroundColor: PjColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<CbAuthScreen, StAuthScreen>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                signInSuccessful: () {
                  context.router.replace(MainRoute());
                },
                error: (code, message) {
                  showAlertDialog(context, message!);
                });
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => _buildSignInContent(context),
            loading: () => const PjLoader(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Form(
          key: _formKeySignIn,
          child: Column(
            children: [
              const PjText(
                "C возвращением!",
                style: PjTextStyle.h1,
                color: PjColors.neonBlue,
              ),
              SizedBox(
                height: 10.h,
              ),
              const PjText("Выполните вход в Only Gym", style: PjTextStyle.regular),
              SizedBox(
                height: 50.h,
              ),
              PjTextField(title: "Email", controller: _emailController, type: PjTextFieldStyle.email),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                title: "Пароль",
                controller: _passwordController,
                type: PjTextFieldStyle.password,
              ),
              if (isPressed && _formKeySignIn.currentState != null && !_formKeySignIn.currentState!.validate()) ...[
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Пожалуйста, заполните отмеченные поля',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                if (!GetUtils.isEmail(_emailController.text) && _emailController.text.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      'Email указан неверно',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
                if (_passwordController.text.isNotEmpty && _passwordController.text.length < 6) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      'Пароль должен содержать более 6 символов',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 48.w,
                  ),
                  const PjText("Забыли пароль?", style: PjTextStyle.medium),
                  PjTextButton(
                      textColor: PjColors.neonBlue,
                      textStyle: PjTextStyle.medium,
                      text: "Нажмите сюда",
                      type: PjTextButtonType.left,
                      onPressed: () {
                        context.router.push(RecoverPasswordRoute());
                      })
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              PjFilledButton(
                  text: "Войти",
                  onPressed: () {
                    if (_formKeySignIn.currentState!.validate()) {
                      context
                          .read<CbAuthScreen>()
                          .login(email: _emailController.text, password: _passwordController.text);
                    } else {
                      setState(() {
                        isPressed = true;
                      });
                    }
                  }),
              SizedBox(
                height: 10.h,
              ),
              PjTextButton(
                textColor: PjColors.lightBlue,
                text: "Зарегистрироваться",
                textStyle: PjTextStyle.bold,
                type: PjTextButtonType.center,
                onPressed: () {
                  setState(() {
                    isPressed = false;
                    context.router.push(RegistrationRoute());
                    /* _emailController = TextEditingController();

                    _passwordController = TextEditingController();
                    context.read<CbAuthScreen>().emit(StAuthScreen.signUp());*/
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
