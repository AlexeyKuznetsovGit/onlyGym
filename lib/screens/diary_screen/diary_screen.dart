import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/current_exercises_screen/widget/current_exercise_card.dart';
import 'package:onlygym/screens/diary_screen/widgets/calendar.dart';
import 'package:onlygym/screens/diary_screen/widgets/my_training_card.dart';
import 'cubit/cb_diary_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DiaryScreen extends StatefulWidget implements AutoRouteWrapper {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbDiaryScreen>(
      create: (context) => CbDiaryScreen()..getData(),
      child: this,
    );
  }
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime dateTimeNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CbDiaryScreen, StDiaryScreen>(
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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Calendar(),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                    10,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: MyTrainingCard(
                      title: "Моя тренировка",
                      time: "16:00",
                      callback: () {},
                    ),
                        )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
