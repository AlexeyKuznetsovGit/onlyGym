import 'dart:async';
import 'dart:developer';

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
import 'package:onlygym/project_widgets/pj_buttons/pj_radio_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_screen/widgets/bs_text_filed_fill.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/my_target_screen/cubit/cb_my_target_screen.dart';
import 'package:onlygym/screens/my_target_screen/widgets/text_field_fill.dart';

@RoutePage()
class MyTargetScreen extends StatefulWidget implements AutoRouteWrapper {
  final UserModel? user;

  const MyTargetScreen({Key? key, this.user}) : super(key: key);

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
      bottomNavigationBar: widget.user == null
          ? Container(
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
            )
          : null,
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
            PjText(
              widget.user != null ? "Цель атлета" : "Моя цель",
              style: PjTextStyle.h1,
              color: PjColors.neonBlue,
            ),
            SizedBox(
              height: 10.h,
            ),
            PjText(
              "Выберите${widget.user != null ? " " : " свою"} основную цель",
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
                          context.read<CbMyTargetScreen>().isSubmitted = false;
                          selectedOption = newOption;
                        });
                      },
                      selectedOption: selectedOption,
                    ))),
            TextFieldFill(
              title: anotherTarget,
              onTap: () {
                setState(() {
                  selectedOption = controller.text;
                });
              },
              onChange: (String newOption) {
                setState(() {
                  selectedOption = newOption;
                });
              },
              selectedOption: selectedOption,
              controller: controller,
            ),
            SizedBox(
              height: 30.h,
            ),
            PjFilledButton(
                text: widget.user != null ? "Добавить атлета" : "Зарегистрироваться",
                onPressed: () {
                  if (selectedOption != '') {
                    if (widget.user != null) {
                      widget.user!.goal = selectedOption;
                      context.read<CbMyTargetScreen>().createNewAthlete(widget.user!);
                      context.router.pushAndPopUntil(MainRoute(children: [AthletesRoute()]), predicate: (_) => false);

                      return;
                    }
                    SgAppData.instance.user.goal = selectedOption;
                    log(selectedOption, name: 'selectedOption');
                    context.router.push(IdConfirmationRoute());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
