import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/exercise_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/loader_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/current_exercises_screen/widget/current_exercise_card.dart';
import 'package:onlygym/screens/exercises_screen/widgets/button_exercise_list.dart';
import 'package:onlygym/screens/profile_screen/widgets/volumeDiagram.dart';
import 'package:onlygym/screens/selected_exercise_screen/cubit/cb_selected_exercise_screen.dart';
import 'package:onlygym/screens/selected_exercise_screen/widget/description_field.dart';
import 'package:onlygym/screens/selected_exercise_screen/widget/round_field.dart';

@RoutePage()
class SelectedExerciseScreen extends StatefulWidget implements AutoRouteWrapper {
  final ValuesModel value;
  final String exerciseTypeName;
  final String groupName; // Пока так, надо делать запрос на конкретное упражнение
  final bool myExercise;

  const SelectedExerciseScreen(
      {Key? key, required this.value, required this.exerciseTypeName, required this.groupName, this.myExercise = true})
      : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbSelectedExerciseScreen>(
      create: (context) => CbSelectedExerciseScreen(),
      child: this,
    );
  }

  @override
  State<SelectedExerciseScreen> createState() => _SelectedExerciseScreenState();
}

class _SelectedExerciseScreenState extends State<SelectedExerciseScreen> {
  List<int> counts = [45, 25, 30, 10, 20, 35, 15];
  int max = 0;
  List<String> weeks = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
  bool readMore = true;

  @override
  void initState() {
    max = counts.reduce((curr, next) => curr > next ? curr : next);
    if (max == 0) {
      max = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.white,
      appBar: PjAppBar(
        title: 'Упражнение',
        actions: [
          Icon(
            CustomIcons.edit,
            size: 24.w,
            color: PjColors.black,
          ),
          SizedBox(
            width: 20.w,
          ),
          Icon(
            CustomIcons.trash,
            size: 24.w,
            color: PjColors.black,
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
        leading: () {
          context.router.pop();
        },
      ),
      body: BlocConsumer<CbSelectedExerciseScreen, StSelectedExerciseScreen>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              loading: () {
                showLoader(context);
              },
              error: (code, message) {
                showAlertDialog(context, message ?? '', true);
              });
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () => _buildBodyContent(context),
          init: () => PjLoader(),
          loaded: () => _buildBodyContent(context),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            CurrentExerciseCard(
              title: widget.value.name ?? 'Гиперэкстензия',
              type: widget.exerciseTypeName,
              callback: () {},
              value: widget.value,
            ),
            SizedBox(
              height: 20.h,
            ),
            DescriptionField(
              text: widget.value.description ?? 'Ваше описание могло бы быть здесь',
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 42.h,
              child: ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ButtonExerciseList(
                    isActive: true,
                    index: index,
                    callback: () {},
                    text: widget.groupName,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 203.h,
              width: 334.w,
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r), border: Border.all(color: PjColors.ultraLightBlue)),
              child: Column(
                children: [
                  Container(
                    height: 22.h,
                    width: 294.w,
                    child: Row(
                      children: [
                        Text(
                          'Динамика весов',
                          style: TextStyle(
                              fontFamily: "PtRoot",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              height: 16 / 22,
                              color: PjColors.black),
                        ),
                        Spacer(),
                        Text(
                          'Неделя',
                          style: TextStyle(
                              fontFamily: "PtRoot",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              height: 14 / 22,
                              color: PjColors.black),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Icon(
                            CustomIcons.arrow_right,
                            size: 19.w,
                            color: PjColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 294.w,
                      height: 113.h,
                      padding: EdgeInsets.only(bottom: 29.h),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            behavior: HitTestBehavior.translucent,
                            child: VolumeDiagram(
                              height: 87 / (max / counts[index]),
                              //87 это максимальная высота одного элемента диаграммы
                              count: counts[index],
                              weekDay: weeks[index],
                            ),
                          );
                        },
                        itemCount: weeks.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (!widget.myExercise)
              ...List.generate(
                2,
                (index) => RoundField(
                  date: '14 апреля 2023',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
