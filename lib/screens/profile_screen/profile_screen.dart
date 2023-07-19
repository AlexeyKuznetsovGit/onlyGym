import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:onlygym/screens/profile_screen/widgets/body_parts.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_settings.dart';
import 'package:onlygym/screens/profile_screen/widgets/empty_avatar.dart';
import 'package:onlygym/screens/profile_screen/widgets/info_card.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbProfileScreen>(
      create: (context) => CbProfileScreen(),
      child: this,
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(
        title: 'Профиль',
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                barrierColor: PjColors.black.withOpacity(0.5),
                context: context,
                builder: (BuildContext ctx) {
                  return const BottomSheetSettingsWidget();
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Icon(
                CustomIcons.settings,
                color: PjColors.black,
                size: 24.w,
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<CbProfileScreen, StProfileScreen>(
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              context.router.push(ProfileImageRoute());
            },
            child: Center(
              child: EmptyAvatar(),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          const PjText(
            'Казаков Вадим',
            style: PjTextStyle.h1,
          ),
          SizedBox(
            height: 10.h,
          ),
          PjText(
            'sniperaft@bk.ru',
            style: PjTextStyle.regular,
            color: PjColors.gray,
          ),
          SizedBox(height: 30.h),
          /*
          SizedBox(height: 40.h),

          SizedBox(height: 40.h),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(callback: () {}, title: "Возраст, лет", data: "21"),
              SizedBox(
                width: 20.w,
              ),
              InfoCard(callback: () {}, title: "Вес, кг", data: "64"),
              SizedBox(
                width: 20.w,
              ),
              InfoCard(callback: () {}, title: "Рост, см", data: "179"),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          InfoCard(isLong: true, callback: () {}, title: "Моя цель", data: "Улучшение формы"),
          SizedBox(
            height: 20.h,
          ),
          BodyParts()
        ],
      ),
    );
  }
}
