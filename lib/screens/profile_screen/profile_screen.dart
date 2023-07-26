import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/loader_dialog.dart';
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
import 'package:onlygym/screens/profile_screen/widgets/size_info_card.dart';

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
  void initState() {
    if (SgAppData.instance.user.photos!.isEmpty) {
      String codePoint = GetStorage().read('localAvatar') ?? 'e82e';
      SgAppData.instance.localAvatar =
          IconData(int.parse(codePoint, radix: 16), fontFamily: 'CustomIcons', fontPackage: null);
    }
    super.initState();
  }

  bool isExpanded = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(
        title: 'Профиль',
        actions: [
          GestureDetector(
            onTap: () {
              context.read<CbProfileScreen>().isSubmitted;

              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                barrierColor: PjColors.black.withOpacity(0.5),
                context: context,
                builder: (ctx) {
                  CbProfileScreen cubit = BlocProvider.of<CbProfileScreen>(context); //Еще не пробовал
                  return BottomSheetSettingsWidget(
                    cubit: cubit,
                  );
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
          state.when(loaded: () {
            if(loading){
                  Navigator.pop(context);
                  loading = false;
                }
          }, loading: ()  {
            loading = true;
            showLoader(context, true);

          }, error: (code, message) {
            showAlertDialog(context, message!);
          });
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () => _buildBodyContent(context),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
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
              child: SgAppData.instance.user.photos!.isEmpty
                  ? EmptyAvatar()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.network(
                        "${PjUtils.imageUrl}${SgAppData.instance.user.photos![0].url!}",
                        height: 98.h,
                        width: 98.w,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          PjText(
            '${SgAppData.instance.user.lastName} ${SgAppData.instance.user.firstName}',
            style: PjTextStyle.h1,
          ),
          SizedBox(
            height: 10.h,
          ),
          PjText(
            SgAppData.instance.user.email!,
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
              InfoCard(
                  callback: () {},
                  title: "Возраст, лет",
                  data: calculateAge(DateTime.parse(SgAppData.instance.user.dateBirth!)).toString()),
              SizedBox(
                width: 20.w,
              ),
              InfoCard(
                  callback: () {}, title: "Вес, кг", data: SgAppData.instance.user.parameters![1].value.toString()),
              SizedBox(
                width: 20.w,
              ),
              InfoCard(
                  callback: () {}, title: "Рост, см", data: SgAppData.instance.user.parameters![0].value.toString()),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          InfoCard(isLong: true, callback: () {}, title: "Моя цель", data: SgAppData.instance.user.goal!),
          SizedBox(
            height: 20.h,
          ),
          BodyParts(),
        ],
      ),
    );
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
