import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:onlygym/screens/profile_screen/widgets/size_info_card.dart';

class BodyParts extends StatefulWidget {
  final CbProfileScreen cubit;

  BodyParts({
    required this.cubit,
    super.key,
  });

  @override
  State<BodyParts> createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isExpanded ? 50.h : 0),
      width: 334.w,
      height: isExpanded ? 577.h : 167.h,
      decoration: BoxDecoration(
        border: Border.all(color: PjColors.ultraLightBlue),
        borderRadius: BorderRadius.circular(20.r),
        color: PjColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.h,
          ),
          PjText(
            'Объём частей тела, см',
            style: PjTextStyle.tiny,
            color: PjColors.gray,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizeInfoCard(
                idParam: 3,
                cubit: widget.cubit,
                callback: () {},
                title: "Шея",
                icon: CustomIcons.neck,
                data: widget.cubit.getCurrentParameter("Шея"),
              ),
              SizedBox(
                width: 11.w,
              ),
              SizeInfoCard(
                idParam: 4,
                cubit: widget.cubit,
                callback: () {},
                title: "Плечи",
                icon: CustomIcons.shoulders,
                data: widget.cubit.getCurrentParameter("Плечи"),
              ),
              SizedBox(
                width: 11.w,
              ),
              SizeInfoCard(
                idParam: 5,
                cubit: widget.cubit,
                callback: () {},
                title: "Грудь",
                icon: CustomIcons.chest,
                data: widget.cubit.getCurrentParameter("Грудь"),
              ),
            ],
          ),
          if (isExpanded) ...[
            Flexible(
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                // Количество колонок
                childAspectRatio: 147.w / 72.h,
                children: List.generate(10, (index) {
                  return SizeInfoCard(
                    idParam: index + 6,
                    cubit: widget.cubit,
                    callback: () {},
                    title: getTitleOrIcon(index),
                    icon: getTitleOrIcon(index, returnTitle: false),
                    isLong: true,
                    data: widget.cubit.getCurrentParameter(getTitleOrIcon(index)),
                  );
                }),
              ),
            ),
          ],
          SizedBox(
            height: isExpanded ? 5.h : 15.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: SizedBox(
              height: 22.h,
              width: 294.w,
              child: Center(
                child: PjText(
                  isExpanded ? 'Скрыть' : 'Смотреть далее',
                  style: PjTextStyle.medium,
                  color: PjColors.neonBlue,
                ),
              ),
            ),
          ),
          if (isExpanded) ...[
            SizedBox(
              height: 15.h,
            ),
          ]
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
            title = 'Левое плечо';
          } else {
            icon = CustomIcons.left_shoulder;
          }
          break;
        }
      case 1:
        {
          if (returnTitle) {
            title = 'Правое плечо';
          } else {
            icon = CustomIcons.right_shoulder;
          }
          break;
        }
      case 2:
        {
          if (returnTitle) {
            title = 'Левое предплечье';
          } else {
            icon = CustomIcons.left_forearm;
          }
          break;
        }
      case 3:
        {
          if (returnTitle) {
            title = 'Правое предплечье';
          } else {
            icon = CustomIcons.right_forearm;
          }
          break;
        }
      case 4:
        {
          if (returnTitle) {
            title = 'Талия';
          } else {
            icon = CustomIcons.waist;
          }
          break;
        }
      case 5:
        {
          if (returnTitle) {
            title = 'Бёдра';
          } else {
            icon = CustomIcons.hips;
          }
          break;
        }
      case 6:
        {
          if (returnTitle) {
            title = 'Левое бедро';
          } else {
            icon = CustomIcons.left_hip;
          }
          break;
        }
      case 7:
        {
          if (returnTitle) {
            title = 'Правое бедро';
          } else {
            icon = CustomIcons.right_hip;
          }
          break;
        }
      case 8:
        {
          if (returnTitle) {
            title = 'Левая голень';
          } else {
            icon = CustomIcons.left_shin;
          }
          break;
        }
      case 9:
        {
          if (returnTitle) {
            title = 'Правая голень';
          } else {
            icon = CustomIcons.right_shin;
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
