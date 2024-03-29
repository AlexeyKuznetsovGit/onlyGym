import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/models/photos_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
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
  void initState() {
    if (!widget.isRegistration) {
      selectedIndex = getIndex();
    }
    super.initState();
  }

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
              addPhotoSuccess: () {
                context.router.pop();
              },
              error: (code, message) {
                showAlertDialog(context, message!);
              });
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () => _buildBodyContent(context),
          loading: () => const PjLoader(),
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
              physics: ClampingScrollPhysics(),
              crossAxisCount: 3,
              // Количество колонок
              childAspectRatio: 98.w / 98.h,
              children: List.generate(9, (index) {
                return index == 0 && SgAppData.instance.avatar == null
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        onLongPress: () async {
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
                                title: 'Фото',
                                changePhoto: false,
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
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              /*else {
                                setState(() {
                                  selectedIndex = 1;
                                  SgAppData.instance.localAvatar = getIcon(selectedIndex);
                                });
                              }*/
                              /*if (res != null && res) {
                                SgAppData.instance.avatar = null;
                                setState(() {
                                  selectedIndex = 1;
                                  SgAppData.instance.localAvatar = getIcon(selectedIndex);
                                });
                              }*/
                            },
                            onLongPress: () async {
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
                                    title: 'Фото',
                                    changePhoto: true,
                                  );
                                },
                              );
                              if (path != null) {
                                setState(() {
                                  SgAppData.instance.localAvatar = null;
                                  SgAppData.instance.avatar = path;
                                });
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: SgAppData.instance.avatar!.contains('http')
                                  ? Image.network(
                                      SgAppData.instance.avatar!,
                                      width: 98.w,
                                      height: 98.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
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
            onPressed: () {
              if (selectedIndex == 0 && SgAppData.instance.avatar != null) {
                SgAppData.instance.localAvatar = null;
                GetStorage().remove('localAvatar');
                if (!widget.isRegistration) {
                  context.read<CbProfileImageScreen>().addAvatar(image: SgAppData.instance.avatar!);
                }
              } else {
                GetStorage().write('localAvatar', SgAppData.instance.localAvatar?.codePoint.toRadixString(16));
                if (!widget.isRegistration) {
                  context.read<CbProfileImageScreen>().emit(StProfileImageScreen.addPhotoSuccess());
                }
              }
              if (widget.isRegistration) {
                context.router.push(BirthdayRoute());
              }
              /*if (selectedIndex < images.length) {
                      SgAppData.instance.localAvatar = null;
                      print('Загружаем аватар');
                      GetStorage().remove('localAvatar');
                      context.read<CbProfileImageScreen>().addAvatar(images: images);
                    } else {
                      print('Загружаем локальный аватар');
                      GetStorage().write('localAvatar', SgAppData.instance.localAvatar?.codePoint.toRadixString(16));
                      context.read<CbProfileImageScreen>().emit(StProfileImageScreen.addPhotoSuccess());
                      log(SgAppData.instance.avatar.toString(), name: 'avatar');
                      log(SgAppData.instance.localAvatar.toString(), name: 'LocalAvatar');
                    }*/
            },
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

  int getIndex() {
    late int index;
    if (SgAppData.instance.localAvatar != null) {
      if (SgAppData.instance.localAvatar == CustomIcons.avatar) {
        index = 1;
      } else if (SgAppData.instance.localAvatar == CustomIcons.sports_kettlebell) {
        index = 2;
      } else if (SgAppData.instance.localAvatar == CustomIcons.dumbbell) {
        index = 3;
      }
    } else {
      index = 0;
    }
    return index;
  }
}

///Todo вариант для отображения большого кол-ва фоток
/*
List.generate(
images.length + 4,
(index) => index == 0
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
isAddedPhoto = true;
images.add(path);
});
}
},
child: Icon(
getIcon(index),
size: 98.w,
color: PjColors.neonBlue,
),
)
    : index < images.length + 1
? GestureDetector(
onTap: () async {
setState(() {
selectedIndex = index;
});
bool? res = await showModalBottomSheet(
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
if (res != null && res) {
setState(() {
images.removeAt(index - 1);
});
}
},
child: ClipRRect(
borderRadius: BorderRadius.circular(100.r),
child: images[index - 1].contains('http')
? Image.network(
images[index - 1],
width: selectedIndex == index ? size : 98.w,
height: selectedIndex == index ? size : 98.h,
fit: BoxFit.cover,
)
    : Image.file(
File(images[index - 1]),
width: selectedIndex == index ? size : 98.w,
height: selectedIndex == index ? size : 98.h,
fit: BoxFit.cover,
),
),
)
    : GestureDetector(
onTap: () {
setState(() {
print(selectedIndex > images.length);
selectedIndex = index;
SgAppData.instance.localAvatar = getIcon(index - 1, false);
});
},
child: Icon(
getIcon(index - 1, false),
size: 98.w,
color: index == selectedIndex ? PjColors.neonBlue : PjColors.lightBlue,
),
))*/
