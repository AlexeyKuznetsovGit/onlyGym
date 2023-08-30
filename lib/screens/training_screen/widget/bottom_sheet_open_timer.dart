import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';

import '../../../project_widgets/pj_custom_picker.dart';

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
                GestureDetector(
                  onTap: () async {
                    String? res = await showModalBottomSheet(
                      useRootNavigator: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      isScrollControlled: true,
                      barrierColor: PjColors.black.withOpacity(0.5),
                      context: context,
                      builder: (ctx) {
                        return PjCustomPicker(
                          isTime: false,
                        );
                      },
                    );
                    if (res != null) {
                      setState(() {
                        controllerCount.text = res;
                      });
                    }
                  },
                  child: PjTextField(
                    title: 'Количество раундов',
                    type: PjTextFieldStyle.number,
                    controller: controllerCount,
                    enabled: false,
                  ),
                ),
                if (widget.isCardio) ...[
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? res = await showModalBottomSheet(
                        useRootNavigator: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        isScrollControlled: true,
                        barrierColor: PjColors.black.withOpacity(0.5),
                        context: context,
                        builder: (ctx) {
                          return PjCustomPicker(
                            isTime: true,
                          );
                        },
                      );
                      if (res != null) {
                        setState(() {
                          controllerTimeRound.text = res;
                        });
                      }
                    },
                    child: PjTextField(
                      title: 'Время раунда',
                      type: PjTextFieldStyle.number,
                      enabled: false,
                      controller: controllerTimeRound,
                    ),
                  ),
                ],
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () async {
                    String? res = await showModalBottomSheet(
                      useRootNavigator: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      isScrollControlled: true,
                      barrierColor: PjColors.black.withOpacity(0.5),
                      context: context,
                      builder: (ctx) {
                        return PjCustomPicker(
                          isTime: true,
                        );
                      },
                    );
                    if (res != null) {
                      setState(() {
                        controllerTimeRelax.text = res;
                      });
                    }
                  },
                  child: PjTextField(
                    title: 'Время отдыха',
                    type: PjTextFieldStyle.number,
                    enabled: false,
                    controller: controllerTimeRelax,
                  ),
                ),
                if (isPressed && _formKey.currentState != null && !_formKey.currentState!.validate()) ...[
                  if (controllerTimeRelax.text.isEmpty || controllerCount.text.isEmpty) ...[
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
                    buttonColor: controllerTimeRelax.text.isNotEmpty && controllerCount.text.isNotEmpty
                        ? PjColors.neonBlue
                        : PjColors.white,
                    text: 'Открыть таймер',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context, rootNavigator: true).pop();
                        context.router.push<bool>(TimerRoute());
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
