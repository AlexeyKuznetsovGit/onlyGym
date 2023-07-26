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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/screens/registration_screen/cubit/cb_registration_screen.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget implements AutoRouteWrapper {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbRegistrationScreen>(
      create: (context) => CbRegistrationScreen(),
      child: this,
    );
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKeySignUp = GlobalKey<FormState>();

  bool isPressed = false;

  String _repeatPassword = '';

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _repeatPasswordController = TextEditingController();



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
        child: BlocConsumer<CbRegistrationScreen, StRegistrationScreen>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                error: (code, message) {
                  showAlertDialog(context, message!);
                });
          },
          builder: (context, state) => state.maybeWhen(
              orElse: () => _buildSignUpContent(context),
              loading: () => const PjLoader(),
          ),
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

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child:  Text(
                  "Зарегистрируйтесь в Only Gym и начинайте\n\nтренироваться",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "PtRoot",
                    letterSpacing: 0,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 16 / 22,
                    color: PjColors.black,
                    leadingDistribution: TextLeadingDistribution.even,),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              PjTextField(title: "Имя", controller: _nameController, type: PjTextFieldStyle.text),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(title: "Фамилия", controller: _lastNameController, type: PjTextFieldStyle.text),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                title: "Email",
                controller: _emailController,
                type: PjTextFieldStyle.email,
              ),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                repeatPassword: _repeatPasswordController.text,
                title: "Пароль",
                controller: _passwordController,
                type: PjTextFieldStyle.password,
                onChanged: (value) {
                  setState(() {
                    _repeatPassword = _repeatPasswordController.text;
                  });
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(
                  onChanged: (value) {
                    setState(() {
                      _repeatPassword = _passwordController.text;
                    });
                  },
                  repeatPassword: _repeatPassword,
                  title: "Повторение пароля",
                  controller: _repeatPasswordController,
                  type: PjTextFieldStyle.password),
              if (isPressed && _formKeySignUp.currentState != null && !_formKeySignUp.currentState!.validate()) ...[
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
                if (_passwordController.text.isNotEmpty && _passwordController.text.length < 6 ||
                    _passwordController.text != _repeatPasswordController.text) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      _passwordController.text.length < 6 && _passwordController.text != _repeatPasswordController.text
                          ? 'Пароль должен содержать более 6 символов\nи совпадать с веденным ранее'
                          : _passwordController.text.length < 6
                          ? 'Пароль должен содержать более 6 символов'
                          : _passwordController.text != _repeatPasswordController.text
                          ? 'Пароль должен совпадать с веденным ранее'
                          : '',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]
              ],
              SizedBox(
                height: 30.h,
              ),
              PjFilledButton(
                  text: "Продолжить",
                  onPressed: () {
                    if (_formKeySignUp.currentState!.validate()) {
                      SgAppData.instance.user.email = _emailController.text;
                      SgAppData.instance.user.firstName = _nameController.text;
                      SgAppData.instance.user.lastName = _lastNameController.text;
                      SgAppData.instance.password = _passwordController.text;
                      context.router.push(ProfileImageRoute(isRegistration: true));
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
                    context.router.pop();
                    /*_nameController = TextEditingController();

                    _lastNameController = TextEditingController();

                    _emailController = TextEditingController();

                    _passwordController = TextEditingController();

                    _repeatPasswordController = TextEditingController();

                    context.read<CbAuthScreen>().emit(StAuthScreen.signIn());*/
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
