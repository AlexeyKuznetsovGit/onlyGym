import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/profile_image_screen/cubit/cb_profile_image_screen.dart';
import 'package:onlygym/screens/profile_image_screen/widgets/bottom_sheet_photo.dart';

@RoutePage()
class ProfileImageScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProfileImageScreen({Key? key, this.isRegistration = false}) : super(key: key);
  final bool isRegistration;

  @override
  State<ProfileImageScreen> createState() => _ProfileImageScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbProfileImageScreen>(
      create: (context) => CbProfileImageScreen(),
      child: this,
    );
  }
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(
        leading: () {
          context.router.pop();
        },
      ),
      body: BlocConsumer<CbProfileImageScreen, StProfileImageScreen>(
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
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          PjText(
            'Изображение профиля',
            style: PjTextStyle.h1,
            color: PjColors.neonBlue,
          ),
          SizedBox(
            height: 10.h,
          ),
          PjText(
            'Загрузите фото или выберите аватар',
            style: PjTextStyle.regular,
            color: PjColors.black,
          ),
          Container(
            height: 334.h,
            width: 334.w,
            margin: EdgeInsets.only(top: 50.h),
            child: GridView.count(
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              // Количество колонок
              childAspectRatio: 98.w / 98.h,
              children: List.generate(9, (index) {
                return index == 0 && SgAppData.instance.avatar == null
                    ? GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedIndex = index;
                          });
                          String? path = await showModalBottomSheet(
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
                              return BottomSheetPhotoWidget(
                                deletePhoto: false,
                              );
                            },
                          );
                          if (path != null) {
                            setState(() {
                              SgAppData.instance.localAvatar = null;
                              SgAppData.instance.avatar = path;
                            });
                          } else {
                            setState(() {
                              selectedIndex = 1;
                              SgAppData.instance.localAvatar = getIcon(selectedIndex);
                            });
                          }
                        },
                        child: Icon(
                          getIcon(index),
                          size: 98.w,
                          color: PjColors.neonBlue,
                        ),
                      )
                    : index == 0 && SgAppData.instance.avatar != null
                        ? GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedIndex = index;
                              });
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
                                  return BottomSheetPhotoWidget(
                                    deletePhoto: true,
                                  );
                                },
                              );
                              if (SgAppData.instance.avatar == null) {
                                setState(() {
                                  selectedIndex = 1;
                                  SgAppData.instance.localAvatar = getIcon(selectedIndex);
                                });
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.file(
                                File(SgAppData.instance.avatar!),
                                width: 98.w,
                                height: 98.h,
                                fit: BoxFit.cover,
                              ),
                            ))
                        : index > 0 && index < 4
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    SgAppData.instance.localAvatar = getIcon(index);
                                  });
                                },
                                child: Icon(
                                  getIcon(index),
                                  size: 98.w,
                                  color: index == selectedIndex ? PjColors.neonBlue : PjColors.lightBlue,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: PjColors.lightBlue,
                                ),
                              );
              }),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          PjFilledButton(
            text: widget.isRegistration ? 'Продолжить' : 'Сохранить изменения',
            onPressed: widget.isRegistration
                ? () {
                    if (selectedIndex == 0 && SgAppData.instance.avatar != null) {
                      SgAppData.instance.localAvatar = null;
                      print('Загружаем аватар');
                      log(SgAppData.instance.avatar.toString(), name: 'avatar');
                      log(SgAppData.instance.localAvatar.toString(), name: 'LocalAvatar');
                    } else {
                      print('Загружаем локальный аватар');
                      GetStorage().write('localAvatar', SgAppData.instance.localAvatar?.codePoint.toRadixString(16));
                      log(SgAppData.instance.avatar.toString(), name: 'avatar');
                      log(SgAppData.instance.localAvatar.toString(), name: 'LocalAvatar');
                    }

                    context.router.push(BirthdayRoute());
                  }
                : () {},
          )
        ],
      ),
    );
  }

  IconData getIcon(int index) {
    late IconData icon;

    switch (index) {
      case 0:
        {
          icon = CustomIcons.add_photo;
          break;
        }
      case 1:
        {
          icon = CustomIcons.avatar;

          break;
        }
      case 2:
        {
          icon = CustomIcons.sports_kettlebell;

          break;
        }
      case 3:
        {
          icon = CustomIcons.dumbbell;

          break;
        }
    }
    return icon;
  }
}
