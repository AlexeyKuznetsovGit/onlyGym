import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_text_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'cubit/cb_auth_screen.dart';
import 'cubit/st_auth_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  // @todo Доработать недостающие виджеты
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(),
      backgroundColor: PjColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<CbAuthScreen, StAuthScreen>(
          builder: (context, state){
            if(state is StAuthScreenLoading){
              BlocProvider.of<CbAuthScreen>(context).emit(StAuthScreenLoaded());
              return const Center(child: CupertinoActivityIndicator(),);
            }
            if(state is StAuthScreenLoaded){
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Column(
                    children: [
                      const PjText("C возвращением!", style: PjTextStyle.h1, color: PjColors.neonBlue,),
                      SizedBox(height: 10.h,),
                      const PjText("Выполните вход в Only Gym", style: PjTextStyle.regular),
                      SizedBox(height: 50.h,),
                      PjTextField(title: "Email", controller: TextEditingController()),
                      SizedBox(height: 20.h,),
                      PjTextField(title: "Пароль", controller: TextEditingController(), isPassword: true,),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          SizedBox(width: 48.w,),
                          const PjText("Забыли пароль?", style: PjTextStyle.medium),
                           PjTextButton(text: "(Нет виджета)", type: PjTextButtonType.left, onPressed: (){})
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      PjFilledButton(text: "Войти", onPressed: (){}),
                      SizedBox(height: 10.h,),
                       PjTextButton(text: "Зарегистрироваться", type: PjTextButtonType.center, onPressed: (){print("Click");},)

                    ],
                  ),
                  PjTextButton(text: "(Нет виджета)", type: PjTextButtonType.left, onPressed: (){},)
                ],
              );
            }
            if(state is StAuthScreenError){
              return Container(color: Colors.red);
            }
            return Container(color: Colors.grey);
          },
        ),
      ),
    );
      
  }
}
    