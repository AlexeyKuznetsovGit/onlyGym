import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/models/training_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/loader_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/router/router.dart';
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
      create: (context) => CbDiaryScreen()..getData(DateFormat("yyyy-MM-dd").format(DateTime.now())),
      child: this,
    );
  }
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime dateTimeNow = DateTime.now();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      body: BlocConsumer<CbDiaryScreen, StDiaryScreen>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              success: (training) {

                context.read<CbDiaryScreen>().emit(StDiaryScreen.loaded(training));
              },
              loaded: (_) {
                if (loading) {
                  context.router.pop();
                  loading = false;
                }
              },
              loading: () {
                loading = true;
                showLoader(context);
              },
              error: (code, message) {
                showAlertDialog(context, message ?? '', true);
              });
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () => _buildBodyContent(context, context.read<CbDiaryScreen>().training),
          init: () => PjLoader(),
          loaded: (training) => _buildBodyContent(context, training),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, TrainingModel training) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Calendar(
            dateList: training.dateList!,
          ),
          Expanded(
              child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                ...List.generate(
                    training.trainingList!.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: MyTrainingCard(
                            title: training.trainingList![index].name!,
                            time: training.trainingList![index].time!,
                            callback: () {
                              context.router.push(TrainingRoute(
                                  date:
                                      DateFormat("d MMMM yyyy", 'ru').format(context.read<CbDiaryScreen>().currentDate),
                                  training: training.trainingList![index]));
                            },
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
