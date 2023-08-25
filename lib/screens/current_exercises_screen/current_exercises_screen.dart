import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/exercises_screen/widgets/button_exercise_list.dart';
import 'package:onlygym/screens/exercises_screen/widgets/exercise_card.dart';
import '../../project_widgets/pj_search_app_bar.dart';
import 'cubit/cb_current_exercises_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrentExercisesScreen extends StatefulWidget implements AutoRouteWrapper {
  ExerciseModel exercise;

  CurrentExercisesScreen({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbCurrentExercisesScreen>(
      create: (context) => CbCurrentExercisesScreen(),
      child: this,
    );
  }

  @override
  State<CurrentExercisesScreen> createState() => _CurrentExercisesScreenState();
}

class _CurrentExercisesScreenState extends State<CurrentExercisesScreen> {
  TextEditingController controller = TextEditingController();
  late int group;
  bool searchExercises = false;

  @override
  void initState() {
    group = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          searchExercises = false;
          controller.clear();
        });
      },
      child: Scaffold(
        backgroundColor: PjColors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(42.h),
            child: searchExercises
                ? PjSearchAppBar(
                    clearSearchField: () {
                      setState(() {
                        if (controller.text.isEmpty) {
                          setState(() {
                            searchExercises = false;
                          });
                        } else {
                          controller.clear();
                        }
                      });
                    },
                    controller: controller,
                    onChanged: (v) {
                      setState(() {});
                    })
                : PjAppBar(
                    title: widget.exercise.name!,
                    actions: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          bool? res =
                              await context.router.push<bool>(NewExerciseRoute(typeExercise: widget.exercise.id!));
                          if (res != null && res) {
                            widget.exercise = await context
                                .read<CbCurrentExercisesScreen>()
                                .getData(widget.exercise, widget.exercise.id!);
                          }
                        },
                        child: Icon(
                          CustomIcons.plus,
                          size: 24.w,
                          color: PjColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            searchExercises = !searchExercises;
                          });
                        },
                        child: Icon(
                          CustomIcons.search,
                          size: 24.w,
                          color: PjColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                    ],
                    leading: () {
                      context.router.pop();
                    },
                  )),
        /*PjAppBar(
          searchTitle: searchExercises
              ? PjTextField(
                  title: 'Поиск...',
                  type: PjTextFieldStyle.text,
                  controller: controller,
                  onChanged: (v) {
                    setState(() {});
                  },
                )
              : null,
          actions: searchExercises
              ? null
              : [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      bool? res = await context.router.push<bool>(NewExerciseRoute(typeExercise: widget.exercise.id!));
                      if (res != null && res) {
                        widget.exercise = await context
                            .read<CbCurrentExercisesScreen>()
                            .getData(widget.exercise, widget.exercise.id!);
                      }
                    },
                    child: Icon(
                      CustomIcons.plus,
                      size: 24.w,
                      color: PjColors.black,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        searchExercises = !searchExercises;
                      });
                    },
                    child: Icon(
                      CustomIcons.search,
                      size: 24.w,
                      color: PjColors.black,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                ],
          title: searchExercises ? '' : widget.exercise.name!,
          leading: searchExercises
              ? null
              : () {
                  context.router.pop();
                },
        ),*/
        body: BlocConsumer<CbCurrentExercisesScreen, StCurrentExercisesScreen>(
          listener: (context, state) =>
              state.whenOrNull(error: (code, message) => showAlertDialog(context, message ?? '')),
          builder: (context, state) => state.maybeWhen(
            orElse: () => _buildBodyContent(context),
            init: () => const PjLoader(),
            loaded: () => _buildBodyContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    List<ValuesModel> filtered =
        widget.exercise.groups![group].values!.where((element) => element.name!.contains(controller.text)).toList();
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 42.h,
            child: ListView.builder(
              itemCount: widget.exercise.groups!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ButtonExerciseList(
                  isActive: index == group,
                  index: index,
                  callback: () {
                    setState(() {
                      group = index;
                    });
                  },
                  text: widget.exercise.groups![index].name!,
                );
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Flexible(
            child: ListView.separated(
              itemCount: filtered.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: ExerciseCard(
                      value: filtered[index],
                      callback: () {
                        context.router.push(SelectedExerciseRoute(
                            groupName: widget.exercise.groups![group].name!,
                            value: filtered[index],
                            exerciseTypeName: widget.exercise.name!));
                        print("Гена пидор");
                      }),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
