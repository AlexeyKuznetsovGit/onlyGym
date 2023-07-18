import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_editing.dart';

import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_qr.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_target.dart';

class BottomSheetSettingsWidget extends StatefulWidget {
  const BottomSheetSettingsWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetSettingsWidget> createState() => _BottomSheetSettingsWidgetState();
}

class _BottomSheetSettingsWidgetState extends State<BottomSheetSettingsWidget> {
  List<Set<MaterialState>> buttonState = [
    {MaterialState.selected},
    {MaterialState.selected},
    {MaterialState.selected},
    {MaterialState.selected},
    {MaterialState.selected}
    //так как нету состояния default, то использую то состояние selected, которого нету в кнопке pjLongButton
  ];
  List<MaterialStatesController> controllers = [
    MaterialStatesController(),
    MaterialStatesController(),
    MaterialStatesController(),
    MaterialStatesController(),
    MaterialStatesController()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 486.h,
      decoration: BoxDecoration(
          color: PjColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
      child: Column(
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
                      Navigator.pop(context);
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
                        'Настройки',
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
          ...List.generate(
              5,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: index == 4 ? 0 : 20.h),
                    child: PjLongButton(
                      onPressed: () async {
                        if (!buttonState[index].contains(MaterialState.pressed) && buttonState[index].isNotEmpty) {
                          buttonState[index] = {MaterialState.pressed};
                        } else {
                          buttonState[index] = {MaterialState.selected};
                        }
                        controllers[index].value = buttonState[index];

                        /// Todo: При открытии второго ботомщита, у первого необходимо сделать barrierColor = Colors.transpanent
                        switch (index) {
                          case 0:
                            {
                              await showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                ),
                                isScrollControlled: true,
                                barrierColor: PjColors.black.withOpacity(0.5),
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetEditingWidget();
                                },
                              );
                              buttonState[index] = {MaterialState.selected};
                              controllers[index].value = buttonState[index];
                              break;
                            }
                          case 1:
                            {
                              await showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                ),
                                isScrollControlled: true,
                                barrierColor: PjColors.black.withOpacity(0.5),
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetTargetWidget();
                                },
                              );
                              buttonState[index] = {MaterialState.selected};
                              controllers[index].value = buttonState[index];
                              break;
                            }
                          case 2:
                            {
                              break;
                            }
                          case 3:
                            {
                              await showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                ),
                                isScrollControlled: true,
                                barrierColor: PjColors.black.withOpacity(0.5),
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetQrWidget();
                                },
                              );
                              buttonState[index] = {MaterialState.selected};
                              controllers[index].value = buttonState[index];
                              break;
                            }
                          case 4:
                            {
                              break;
                            }
                        }
                      },
                      icon: getTitleOrIcon(index, returnTitle: false),
                      text: getTitleOrIcon(index),
                      controller: controllers[index],
                    ),
                  ))
        ],
      ),
    );
  }

  dynamic getTitleOrIcon(int index, {bool returnTitle = true}) {
    String title = '';
    late IconData icon;

    switch (index) {
      case 0:
        {
          if (returnTitle) {
            title = 'Редактировать профиль';
          } else {
            icon = CustomIcons.edit;
          }
          break;
        }
      case 1:
        {
          if (returnTitle) {
            title = 'Изменить цель';
          } else {
            icon = CustomIcons.goal;
          }
          break;
        }
      case 2:
        {
          if (returnTitle) {
            title = 'Уведомления включены';
          } else {
            icon = CustomIcons.notification_on;
          }
          break;
        }
      case 3:
        {
          if (returnTitle) {
            title = 'Предоставить доступ к аккаунту';
          } else {
            icon = CustomIcons.qr;
          }
          break;
        }
      case 4:
        {
          if (returnTitle) {
            title = 'Выйти из аккаунта';
          } else {
            icon = CustomIcons.quit;
          }
          break;
        }
    }

    if (returnTitle) {
      return title;
    } else {
      return icon;
    }
  }
}
