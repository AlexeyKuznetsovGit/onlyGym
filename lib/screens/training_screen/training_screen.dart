import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/models/training_model.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/diary_screen/widgets/my_training_card.dart';
import 'package:onlygym/screens/exercises_screen/widgets/exercise_card.dart';
import 'cubit/cb_training_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TrainingScreen extends StatefulWidget implements AutoRouteWrapper {
  final String date;
  final TrainingListModel training;
  const TrainingScreen({Key? key, required this.date, required this.training}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbTrainingScreen>(
      create: (context) => CbTrainingScreen(),
      child: this,
    );
  }
  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(title: widget.date, leading: (){context.router.pop();}, actions: [
        GestureDetector(
          onTap: () {
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
      ],),
      body: BlocConsumer<CbTrainingScreen, StTrainingScreen>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              );
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () =>_buildBodyContent(context),
          init: () => PjLoader(),
          loaded: () => _buildBodyContent(context),
        ),
      ),
    );

  }
  Widget _buildBodyContent(BuildContext context) {
    return SafeArea(child: Center(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: MyTrainingCard(
            title: widget.training.name!,
            time: widget.training.time!,
            callback: () {
            },
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  ...List.generate(
                     6,
                          (index) => Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: ExerciseCard.delete(callback: (){}, deleteCallback: (){},),
                      )),
                ],
              ),
            ))
      ],),
    ));
  }
}
    