import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/registration_screen/cubit/cb_registration_screen.dart';
import 'cubit/cb_create_new_athlete_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateNewAthleteScreen extends StatefulWidget implements AutoRouteWrapper {
  const CreateNewAthleteScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbCreateNewAthleteScreen>(
      create: (context) => CbCreateNewAthleteScreen(),
      child: this,
    );
  }

  @override
  State<CreateNewAthleteScreen> createState() => _CreateNewAthleteScreenState();
}

class _CreateNewAthleteScreenState extends State<CreateNewAthleteScreen> {
  final _formKeySignUp = GlobalKey<FormState>();

  bool isPressed = false;

  String _repeatPassword = '';

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  TextEditingController birthdayController = TextEditingController();

  TextEditingController heightController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  // @todo Доработать недостающие виджеты
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(
        title: '',
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
        child: BlocConsumer<CbCreateNewAthleteScreen, StCreateNewAthleteScreen>(
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
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Form(
        key: _formKeySignUp,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20.w,
              ),
              const PjText(
                "Создание нового атлета",
                style: PjTextStyle.h1,
                color: PjColors.neonBlue,
              ),
              SizedBox(
                height: 10.h,
              ),

              ///Todo потом заменить на pjtext
              Text(
                "Создайте аккаунт нового атлета в Only Gym",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "PtRoot",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 16 / 22,
                  color: PjColors.black,
                  leadingDistribution: TextLeadingDistribution.even,
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
              PjTextField(type: PjTextFieldStyle.date, title: "Дата рождения", controller: birthdayController),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(type: PjTextFieldStyle.params, title: "Рост", controller: heightController),
              SizedBox(
                height: 20.h,
              ),
              PjTextField(type: PjTextFieldStyle.params, title: "Вес", controller: weightController),
              SizedBox(
                height: 30.h,
              ),
              PjFilledButton(
                  text: "Продолжить",
                  onPressed: () {
                    if (_formKeySignUp.currentState!.validate()) {
                      context.router.push(
                        MyTargetRoute(
                          user: UserModel(
                            firstName: _nameController.text,
                            lastName: _lastNameController.text,
                            dateBirth: formatDateToISO(birthdayController.text),
                            parameters: [
                              ParametersModel(name: 'Рост', value: double.parse(heightController.text)),
                              ParametersModel(name: 'Вес', value: double.parse(weightController.text))
                            ],
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isPressed = true;
                      });
                    }
                  }),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
