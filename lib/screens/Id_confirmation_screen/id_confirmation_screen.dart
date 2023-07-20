import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/screens/Id_confirmation_screen/cubit/cb_id_confirmation_screen.dart';

@RoutePage()
class IdConfirmationScreen extends StatelessWidget implements AutoRouteWrapper {
  const IdConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbIdConfirmationScreen>(
      create: (context) => CbIdConfirmationScreen(),
      child: this,
    );
  }

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
              "Подтверждение личности",
              style: PjTextStyle.h1,
              color: PjColors.neonBlue,
            ),
            SizedBox(
              height: 10.h,
            ),
            const PjText(
              "Введите код, отправленный на почту\n\nvvedennayapochta@bk.ru",
              align: TextAlign.center,
              style: PjTextStyle.regular,
            ),
            SizedBox(
              height: 50.h,
            ),
            PjTextField(title: "Код подтверждения", controller: TextEditingController()),
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
                    textColor: PjColors.neonBlue,
                    textStyle: PjTextStyle.medium,
                    text: "Отправить повторно",
                    type: PjTextButtonType.left,
                    onPressed: () {})
              ],
            ),
            SizedBox(height: 30.h,),
            PjFilledButton(text: "Войти", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
