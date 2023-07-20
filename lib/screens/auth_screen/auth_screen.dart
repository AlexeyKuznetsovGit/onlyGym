import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _formKeySignUp = GlobalKey<FormState>();

  bool isPressed = false;

  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController repeatPasswordController = TextEditingController();

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
                error: (code, message) {
                  showAlertDialog(context, message!);
                });
          },
          builder: (context, state) => state.maybeWhen(
              orElse: () => Container(),
              loading: () => const PjLoader(),
              signIn: () => _buildSignInContent(context),
              signUp: () => _buildSignUpContent(context)),
        ),
      ),
    );
  }

  Widget _buildSignUpContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Form(
          key: _formKeySignUp,
          child: Column(
            children: [
              const PjText(
                "Создать аккаунт",
                style: PjTextStyle.h1,
                color: PjColors.neonBlue,
              ),
              SizedBox(
                height: 10.h,
              ),
              const PjText(
                "Зарегистрируйтесь в Only Gym и начинайте\n\nтренироваться",
                align: TextAlign.center,
                style: PjTextStyle.regular,
              ),
              SizedBox(
                height: 50.h,
              ),
              PjTextField(title: "Имя", controller: nameController),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(title: "Фамилия", controller: lastNameController),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(title: "Email", controller: emailController),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                title: "Пароль",
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                title: "Повторение пароля",
                controller: repeatPasswordController,
                isPassword: true,
              ),
              if (isPressed && _formKeySignUp.currentState != null && !_formKeySignUp.currentState!.validate())
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Пожалуйста, заполните отмеченные поля',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                height: 30.h,
              ),
              PjFilledButton(
                  text: "Зарегистрироваться",
                  onPressed: () {
                    if (_formKeySignUp.currentState!.validate()) {
                      context.router.push(IdConfirmationRoute());
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
                text: "Войти",
                textStyle: PjTextStyle.bold,
                type: PjTextButtonType.center,
                onPressed: () {
                  setState(() {
                    isPressed = false;
                    nameController = TextEditingController();

                    lastNameController = TextEditingController();

                    emailController = TextEditingController();

                    passwordController = TextEditingController();

                    repeatPasswordController = TextEditingController();

                    context.read<CbAuthScreen>().emit(StAuthScreen.signIn());
                  });
                },
              ),
            ],
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
              PjTextField(title: "Email", controller: emailController),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                title: "Пароль",
                controller: passwordController,
                isPassword: true,
              ),
              if (isPressed && _formKeySignIn.currentState != null && !_formKeySignIn.currentState!.validate())
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Пожалуйста, заполните отмеченные поля',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
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
                      onPressed: () {})
                ],
              ),

              SizedBox(
                height: 30.h,
              ),
              PjFilledButton(text: "Войти", onPressed: () {
                if (_formKeySignIn.currentState!.validate()) {
                  context.router.replace(MainRoute());
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
                    emailController = TextEditingController();

                    passwordController = TextEditingController();
                    context.read<CbAuthScreen>().emit(StAuthScreen.signUp());
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
