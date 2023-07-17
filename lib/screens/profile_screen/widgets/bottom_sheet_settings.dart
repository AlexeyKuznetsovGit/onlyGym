
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class BottomSheetSettingsWidget extends StatefulWidget {
  const BottomSheetSettingsWidget({super.key});

  @override
  State<BottomSheetSettingsWidget> createState() => _BottomSheetSettingsWidgetState();
}

class _BottomSheetSettingsWidgetState extends State<BottomSheetSettingsWidget> {

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
      ),
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
                  child: Icon(CustomIcons.cross, size: 24.w,color: PjColors.black,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PjText(
                      'Настройки',
                      style: PjTextStyle.title,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          ...List.generate(5, (index) => Padding(
            padding: EdgeInsets.only(bottom: index == 4 ? 0 : 20.h),
            child: PjLongButton(icon: getTitleOrIcon(index,returnTitle: false), text: getTitleOrIcon(index),),
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
