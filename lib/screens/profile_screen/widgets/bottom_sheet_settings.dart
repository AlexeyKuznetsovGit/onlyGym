import 'package:auto_route/auto_route.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_editing.dart';

import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_qr.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_target.dart';

class BottomSheetSettingsWidget extends StatefulWidget {
  final CbProfileScreen cubit;
  final int? athleteId;

  const BottomSheetSettingsWidget({Key? key, this.athleteId, required this.cubit}) : super(key: key);

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

  bool isNotificationsDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.athleteId == null ? 486.h : 342.h,
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
              widget.athleteId == null ? 5 : 3,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: PjLongButton(
                      onPressed: () async {
                        if (index != 2 || widget.athleteId != null) {
                          if (!buttonState[index].contains(MaterialState.pressed) && buttonState[index].isNotEmpty) {
                            buttonState[index] = {MaterialState.pressed};
                          } else {
                            buttonState[index] = {MaterialState.selected};
                          }
                          controllers[index].value = buttonState[index];
                        }

                        /// Todo: При открытии второго ботомщита, у первого необходимо сделать barrierColor = Colors.transpanent
                        if (widget.athleteId == null) {
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
                                  useSafeArea: true,
                                  barrierColor: PjColors.black.withOpacity(0.5),
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetEditingWidget(
                                      cubit: widget.cubit,
                                    );
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
                                  useSafeArea: true,
                                  barrierColor: PjColors.black.withOpacity(0.5),
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: BottomSheetTargetWidget(
                                        cubit: widget.cubit,
                                      ),
                                    );
                                  },
                                );
                                buttonState[index] = {MaterialState.selected};
                                controllers[index].value = buttonState[index];
                                break;
                              }
                            case 2:
                              {
                                setState(() {
                                  isNotificationsDisabled = !isNotificationsDisabled;
                                });

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
                                Api.setToken('');
                                context.router.replace(AuthRoute());
                                break;
                              }
                          }
                        } else {
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
                                  useSafeArea: true,
                                  barrierColor: PjColors.black.withOpacity(0.5),
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetEditingWidget(
                                      cubit: widget.cubit,
                                      athleteId: widget.athleteId,
                                    );
                                  },
                                );
                                buttonState[index] = {MaterialState.selected};
                                controllers[index].value = buttonState[index];
                                break;
                              }
                            case 1:
                              {
                                break;
                              }
                            case 2:
                              {
                                break;
                              }

                          }
                        }
                      },
                      icon: getTitleOrIcon(index, returnTitle: false, isNotificationsDisabled: isNotificationsDisabled, athleteId: widget.athleteId),
                      text: getTitleOrIcon(index, isNotificationsDisabled: isNotificationsDisabled,athleteId: widget.athleteId),
                      controller: controllers[index],
                    ),
                  ))
        ],
      ),
    );
  }

  dynamic getTitleOrIcon(int index, {bool returnTitle = true, bool isNotificationsDisabled = false, int? athleteId}) {
    String title = '';
    late IconData icon;
    if (athleteId == null) {
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
              title = isNotificationsDisabled ? 'Уведомления отключены' : 'Уведомления включены';
            } else {
              icon = isNotificationsDisabled ? CustomIcons.notification_off : CustomIcons.notification_on;
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
    } else {
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
              title = 'Предоставить доступ к аккаунту';
            } else {
              icon = CustomIcons.akk_ok;
            }
            break;
          }
        case 2:
          {
            if (returnTitle) {
              title = 'Удалить атлета';
            } else {
              icon = CustomIcons.akk_cross;
            }
            break;
          }
      }
    }

    if (returnTitle) {
      return title;
    } else {
      return icon;
    }
  }
}
