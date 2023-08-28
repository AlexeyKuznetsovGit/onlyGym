import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/athletes_screen/cubit/cb_athletes_screen.dart';
import 'package:onlygym/screens/diary_screen/cubit/cb_diary_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BottomSheetOpenTimer extends StatefulWidget {
  final double height;
  final bool isCardio;

  const BottomSheetOpenTimer({
    Key? key,
    required this.isCardio,
    required this.height,
  }) : super(key: key);

  @override
  State<BottomSheetOpenTimer> createState() => _BottomSheetOpenTimerState();
}

class _BottomSheetOpenTimerState extends State<BottomSheetOpenTimer> {
  MaterialStatesController myTrainingButtonCtrl = MaterialStatesController();
  MaterialStatesController notMyTrainingButtonCtrl = MaterialStatesController();

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerCount = TextEditingController();
  TextEditingController controllerTimeRelax = TextEditingController();
  TextEditingController controllerTimeRound = TextEditingController();
  TextEditingController controllerTimeToStart = TextEditingController();

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
              color: PjColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(right: 16.w),
                  height: 42.h,
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            context.router.pop();
                          },
                          child: Icon(
                            CustomIcons.cross,
                            size: 24.w,
                            color: PjColors.black,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: PjText(
                              'Выполнение упражнения',
                              style: PjTextStyle.title,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                PjTextField(title: 'Количество раундов', type: PjTextFieldStyle.number, controller: controllerCount),
                SizedBox(
                  height: 20.h,
                ),
                PjTextField(title: 'Время отдыха', type: PjTextFieldStyle.minutes, controller: controllerTimeRelax),
                if (isPressed && _formKey.currentState != null && !_formKey.currentState!.validate()) ...[
                  if (controllerTimeRelax.text.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'Нельзя вводить больше 60 минут',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ] else if (controllerTimeRelax.text.isEmpty || controllerCount.text.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'Заполните отмеченные поля',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ]
                ],
                SizedBox(
                  height: 20.h,
                ),
                PjFilledButton(
                    text: 'Открыть таймер',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      } else {
                        setState(() {
                          isPressed = true;
                        });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
