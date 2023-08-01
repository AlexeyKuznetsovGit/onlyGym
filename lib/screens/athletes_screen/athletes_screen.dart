import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/athletes_screen/widgets/avatar_card.dart';
import 'cubit/cb_athletes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/bottom_sheet_add_athelet.dart';

@RoutePage()
class AthletesScreen extends StatefulWidget implements AutoRouteWrapper {
  const AthletesScreen({Key? key}) : super(key: key);

  @override
  State<AthletesScreen> createState() => _AthletesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbAthletesScreen>(
      create: (context) => CbAthletesScreen()..getData(),
      child: this,
    );
  }
}

class _AthletesScreenState extends State<AthletesScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(covariant AthletesScreen oldWidget) {
    print(123);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(title: 'Атлеты', actions: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
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
                return BottomSheetAddAthelet(
                  height: 270.h,
                  title: 'Атлеты',
                );
              },
            );
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              CustomIcons.plus,
              color: Colors.black,
            ),
          ),
        ),
      ]),
      body: BlocConsumer<CbAthletesScreen, StAthletesScreen>(
        listener: (context, state) =>
            state.whenOrNull(error: (code, message) => showAlertDialog(context, message ?? '')),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          loading: () => const PjLoader(),
          loaded: (users) => _buildBodyContent(context, users),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, List<UserModel> users) {
    List<UserModel> filtered = users
        .where((element) => element.lastName!.contains(controller.text) || element.firstName!.contains(controller.text))
        .toList();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          PjTextField(
            title: 'Поиск атлетов',
            type: PjTextFieldStyle.text,
            controller: controller,
            onChanged: (v) {
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
              itemBuilder: (context, index) => AvatarCard(
                callback: () {
                  context.router.push(ProfileRoute(athleteId: filtered[index].id));
                },
                user: filtered[index],
              ),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 12.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
