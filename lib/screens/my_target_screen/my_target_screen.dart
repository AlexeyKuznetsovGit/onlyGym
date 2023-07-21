import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_radio_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_filed_fill.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/my_target_screen/cubit/cb_my_target_screen.dart';

@RoutePage()
class MyTargetScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyTargetScreen({Key? key}) : super(key: key);

  @override
  State<MyTargetScreen> createState() => _MyTargetScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbMyTargetScreen>(
      create: (context) => CbMyTargetScreen(),
      child: this,
    );
  }
}

class _MyTargetScreenState extends State<MyTargetScreen> {
  List<String> targets = ['Улучшение формы', 'Здоровый образ жизни', 'Похудение', 'Набор мышечной массы'];

  String selectedOption = 'Улучшение формы';
  String anotherTarget = 'Другое';
  TextEditingController controller = TextEditingController(text: 'Другое');
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
        child: BlocConsumer<CbMyTargetScreen, StMyTargetScreen>(
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
    return  Center(
      child: Column(
        children: [
          const PjText(
            "Моя цель",
            style: PjTextStyle.h1,
            color: PjColors.neonBlue,
          ),
          SizedBox(
            height: 10.h,
          ),
          const PjText(
            "Выберите свою основную цель",
            align: TextAlign.center,
            style: PjTextStyle.regular,
          ),
          SizedBox(
            height: 50.h,
          ),

          ...List.generate(
              4,
                  (index) => Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: PjRadioButton(
                    option: targets[index],
                    onChanged: (String newOption) {
                      setState(() {
                        controller.text = 'Другое';
                        selectedOption = newOption;
                      });
                    },
                    selectedOption: selectedOption,
                  ))),
          PjTextFieldFill(
            title: anotherTarget,
            onTap: () {
              setState(() {
                selectedOption = '';
              });
            },
            onChange: (String newOption) {
              setState(() {
                selectedOption = newOption;
              });
            },
            controller: controller,
          ),

          SizedBox(
            height: 30.h,
          ),
          PjFilledButton(
              text: "Зарегистрироваться",
              onPressed: () {
                if(selectedOption != ''){
                  SgAppData.instance.user.goal = selectedOption;
                  log(SgAppData.instance.user.toString(),name: 'user');
                  context.router.push(IdConfirmationRoute());
                }
              }),
        ],
      ),
    );
  }
}
