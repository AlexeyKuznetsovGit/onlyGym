import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_image_screen/cubit/cb_profile_image_screen.dart';

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
                return GestureDetector(
                    onTap: () {},
                    child: index < 4
                        ? Icon(
                            getIcon(index),
                            size: 98.w,
                            color: PjColors.neonBlue,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: PjColors.lightBlue,
                            ),
                          ));
              }),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          PjFilledButton(
            text: widget.isRegistration ? 'Продолжить' : 'Сохранить изменения',
            onPressed: () {},
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
