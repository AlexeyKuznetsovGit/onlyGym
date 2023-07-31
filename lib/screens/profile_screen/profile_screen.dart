import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/models/user_model.dart';
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
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_body_parts.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_settings.dart';
import 'package:onlygym/screens/profile_screen/widgets/empty_avatar.dart';
import 'package:onlygym/screens/profile_screen/widgets/info_card.dart';
import 'package:onlygym/screens/profile_screen/widgets/size_info_card.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  final int? athleteId;

  const ProfileScreen({Key? key, this.athleteId}) : super(key: key);

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
    if (widget.athleteId != null) {
      context.read<CbProfileScreen>().getUser(widget.athleteId!);
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
        leading: widget.athleteId != null
            ? () {
                context.router.pop();
              }
            : null,
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
                builder: (ctx) {
                  CbProfileScreen cubit = BlocProvider.of<CbProfileScreen>(context);
                  return BottomSheetSettingsWidget(
                    athleteId: widget.athleteId,
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
          state.when(
              init: () {},
              loaded: (user) {
                if (loading) {
                  Navigator.pop(context);
                  loading = false;
                }
                /*if (widget.athleteId != null) {
                  user = context.read<CbProfileScreen>().user;
                  log(user.toString(), name: 'Athlete');
                }*/
              },
              loading: () {
                loading = true;
                showLoader(context, true);
              },
              error: (code, message) {
                showAlertDialog(context, message!, false, () {
                  context.read<CbProfileScreen>().emit(StProfileScreen.loaded(
                      widget.athleteId == null ? SgAppData.instance.user : context.read<CbProfileScreen>().user));
                });
              });
        },
        builder: (context, state) => state.maybeWhen(
          init: () => widget.athleteId != null ? PjLoader() : _buildBodyContent(context, SgAppData.instance.user),
          loaded: (userData) => _buildBodyContent(context, userData),
          orElse: () => Container(),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () async {
              if (widget.athleteId == null) {
                await context.router.push(ProfileImageRoute());
                setState(() {});
              }
            },
            child: Center(
              child: widget.athleteId == null
                  ? SgAppData.instance.localAvatar != null
                      ? EmptyAvatar()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.network(
                            SgAppData.instance.avatar!,
                            height: 98.h,
                            width: 98.w,
                            fit: BoxFit.cover,
                          ),
                        )
                  : user.photos!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.network(
                            "${PjUtils.imageUrl}${user.photos!.last.url!}",
                            height: 98.h,
                            width: 98.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      : EmptyAvatar(
                          athleteId: widget.athleteId,
                        ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          PjText(
            '${user.lastName!.capitalizeFirst.toString()} ${user.firstName!.capitalizeFirst.toString()}',
            style: PjTextStyle.h1,
          ),
          SizedBox(
            height: 10.h,
          ),
          PjText(
            user.email!,
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
                  data: calculateAge(DateTime.parse(user.dateBirth!)).toString()),
              SizedBox(
                width: 20.w,
              ),
              InfoCard(
                  callback: () async {
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
                      builder: (BuildContext ctx) {
                        return BottomSheetBodyPartsWidget(
                          athleteId: widget.athleteId,
                          idParam: 2,
                          cubit: BlocProvider.of<CbProfileScreen>(context),
                          data: user.parameters![1].value.toString(),
                          title: "Вес, кг",
                          height: 270.h,
                          type: BottomSheetType.init,
                        );
                      },
                    );
                  },
                  title: "Вес, кг",
                  data: user.parameters![1].value.toString()),
              SizedBox(
                width: 20.w,
              ),
              InfoCard(
                  callback: () async {
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
                      builder: (BuildContext ctx) {
                        return BottomSheetBodyPartsWidget(
                          athleteId: widget.athleteId,
                          idParam: 1,
                          cubit: BlocProvider.of<CbProfileScreen>(context),
                          data: user.parameters![0].value.toString(),
                          title: "Рост, см",
                          height: 270.h,
                          type: BottomSheetType.init,
                        );
                      },
                    );
                  },
                  title: "Рост, см",
                  data: user.parameters![0].value.toString()),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          InfoCard(isLong: true, callback: () {}, title: "Моя цель", data: user.goal!),
          SizedBox(
            height: 20.h,
          ),
          BodyParts(
            athleteId: widget.athleteId,
            user: user,
            cubit: BlocProvider.of<CbProfileScreen>(context),
          ),
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
