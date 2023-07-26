import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:onlygym/screens/registration_screen/widgets/Id_confirmation_screen/cubit/cb_id_confirmation_screen.dart';

@RoutePage()
class IdConfirmationScreen extends StatefulWidget implements AutoRouteWrapper {
  const IdConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<IdConfirmationScreen> createState() => _IdConfirmationScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbIdConfirmationScreen>(
      create: (context) => CbIdConfirmationScreen(),
      child: this,
    );
  }
}

class _IdConfirmationScreenState extends State<IdConfirmationScreen> {
  bool isPressed = false;
  final _formKeyConfirmation = GlobalKey<FormState>();
  Timer _timer = Timer(Duration(), () {});
  TextEditingController confirmationController = TextEditingController();

  @override
  void initState() {
    context.read<CbIdConfirmationScreen>().sendCode(email: SgAppData.instance.user.email!);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int _secondsRemaining = 60;

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
        child: BlocConsumer<CbIdConfirmationScreen, StIdConfirmationScreen>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                signUpSuccessful: () {
                  context.router.replace(MainRoute());
                  SgAppData.instance.password = null;
                },
                error: (code, message) {
                  showAlertDialog(context, message!, true);
                });
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            loading: () => const PjLoader(),
            loaded: (code) => _buildBodyContent(context, code!),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, int code) {
    return Center(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child:  Text(
                "Подтверждение личности",
                style: TextStyle(
                 /* letterSpacing: -0.5,*/
                  fontFamily: "PtRoot",
                  letterSpacing: -0.5,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  height: 28 / 22,
                  color: PjColors.neonBlue,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            PjText(
              "Введите код, отправленный на почту\n\n${SgAppData.instance.user.email}",
              align: TextAlign.center,
              style: PjTextStyle.regular,
            ),
            SizedBox(
              height: 50.h,
            ),
            Form(
                key: _formKeyConfirmation,
                child: PjTextField(
                    checkCode: code,
                    type: PjTextFieldStyle.number,
                    title: "Код подтверждения",
                    controller: confirmationController)),
            if (isPressed &&
                _formKeyConfirmation.currentState != null &&
                !_formKeyConfirmation.currentState!.validate())
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  confirmationController.text.isEmpty ? 'Пожалуйста, заполните поле' : 'Введен неправильный код',
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
                const PjText("Не получили код?", style: PjTextStyle.medium),
                PjTextButton(
                    textColor: _timer.isActive ? PjColors.gray : PjColors.neonBlue,
                    textStyle: PjTextStyle.medium,
                    text: _timer.isActive ? _formatTime(_secondsRemaining) : "Отправить повторно",
                    type: PjTextButtonType.left,
                    onPressed: () {
                      if (!_timer.isActive) {
                        setState(() {
                          _startTimer();
                          context
                              .read<CbIdConfirmationScreen>()
                              .sendCode(email: SgAppData.instance.user.email!, loading: false);
                        });
                      }
                    })
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            PjFilledButton(
                text: "Завершить регистрацию",
                onPressed: () {
                  if (_formKeyConfirmation.currentState!.validate()) {
                    SgAppData.instance.localAvatar != null
                        ? context.read<CbIdConfirmationScreen>().finishRegistration(
                            email: SgAppData.instance.user.email!,
                            password: SgAppData.instance.password!,
                            firstName: SgAppData.instance.user.firstName!,
                            lastName: SgAppData.instance.user.lastName!,
                            dateBirthday: SgAppData.instance.user.dateBirth!,
                            height: SgAppData.instance.user.parameters![0].value!,
                            weight: SgAppData.instance.user.parameters![1].value!,
                            target: SgAppData.instance.user.goal!)
                        : context.read<CbIdConfirmationScreen>().finishRegistration(
                            email: SgAppData.instance.user.email!,
                            password: SgAppData.instance.password!,
                            firstName: SgAppData.instance.user.firstName!,
                            lastName: SgAppData.instance.user.lastName!,
                            dateBirthday: SgAppData.instance.user.dateBirth!,
                            height: SgAppData.instance.user.parameters![0].value!,
                            weight: SgAppData.instance.user.parameters![1].value!,
                            target: SgAppData.instance.user.goal!,
                            pathPhoto: SgAppData.instance.avatar,
                            namePhoto: SgAppData.instance.avatar!.split('/').last);
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

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          timer.cancel();
          _secondsRemaining = 60;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }
}
