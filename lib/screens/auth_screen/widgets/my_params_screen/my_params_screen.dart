import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/user_model.dart';
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
import 'package:onlygym/screens/auth_screen/widgets/Id_confirmation_screen/cubit/cb_id_confirmation_screen.dart';
import 'package:onlygym/screens/auth_screen/widgets/birthday_screen/cubit/cb_birthday_screen.dart';
import 'package:onlygym/screens/auth_screen/widgets/my_params_screen/cubit/cb_my_params_screen.dart';

@RoutePage()
class MyParamsScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyParamsScreen({Key? key}) : super(key: key);

  @override
  State<MyParamsScreen> createState() => _MyParamsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbMyParamsScreen>(
      create: (context) => CbMyParamsScreen(),
      child: this,
    );
  }
}

class _MyParamsScreenState extends State<MyParamsScreen> {
  final _formKeyParams = GlobalKey<FormState>();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
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
        child: BlocConsumer<CbMyParamsScreen, StMyParamsScreen>(
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
            loaded: () => _buildBodyContent(context),
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
              "Мои параметры",
              style: PjTextStyle.h1,
              color: PjColors.neonBlue,
            ),
            SizedBox(
              height: 10.h,
            ),
            const PjText(
              "Укажите свои настоящие рост и вес",
              align: TextAlign.center,
              style: PjTextStyle.regular,
            ),
            SizedBox(
              height: 50.h,
            ),
            Form(
                key: _formKeyParams,
                child: Column(
                  children: [
                    PjTextField(type: PjTextFieldStyle.params, title: "Рост", controller: heightController),
                    SizedBox(
                      height: 20.h,
                    ),
                    PjTextField(type: PjTextFieldStyle.params, title: "Вес", controller: weightController),
                  ],
                )),
            if (isPressed && _formKeyParams.currentState != null && !_formKeyParams.currentState!.validate()) ...[
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  'Пожалуйста, заполните отмеченные поля',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              if ((weightController.text.length > 3 || weightController.text == '0') ||
                  heightController.text.length > 3 ||
                  heightController.text == '0') ...[
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Введены некорректные значения',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ],
            SizedBox(
              height: 30.h,
            ),
            PjFilledButton(
                text: "Продолжить",
                onPressed: () {
                  if (_formKeyParams.currentState!.validate()) {
                    SgAppData.instance.user.parameters = [
                      ParametersModel(name: "Рост", value: double.parse(heightController.text), unit: 'см'),
                      ParametersModel(name: "Вес", value: double.parse(weightController.text), unit: 'кг')
                    ];
                    context.router.push(const MyTargetRoute());
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
