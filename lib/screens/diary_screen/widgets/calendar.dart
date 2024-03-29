import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/screens/current_exercises_screen/widget/current_exercise_card.dart';
import 'package:onlygym/screens/diary_screen/cubit/cb_diary_screen.dart';
import 'package:onlygym/screens/diary_screen/widgets/bottom_sheet_add_training.dart';

import '../../../../project_utils/pj_icons.dart';
import 'calendar_item.dart';

class Calendar extends StatefulWidget {
  final List<String> dateList;

  const Calendar({Key? key, required this.dateList}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //Отвечает за выбранный день
  // DateTime currentDate = DateTime.now();

  DateTime dateTineNow = DateTime.now();

  //Контроллер календаля
  late PageController controllerPage;

  // Лэйбл длякалендаря
  String label = '';

  // Список дат. Генерируется на год вперед и назада от сегодняшнего дня
  List<DateTime> days = [];

  // Происходит ли анимаци, для того чтобы плавно менять даты в лейбле
  bool _isAnimated = false;

  @override
  void initState() {
    days = generateDays();
    controllerPage = PageController(
        viewportFraction: 0.145, initialPage: getCurrentIndex(context.read<CbDiaryScreen>().currentDate));
    label = 'Сегодня';
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerPage.addListener(() {
        if (mounted && _isAnimated == false) {
          setState(() {
            label = DateFormat("d MMMM yyyy", 'ru').format(currentDate);
            print(currentDate);
          });
        }
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 42.h,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: "PtRoot",
                      height: 20 / 22,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: PjColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: ()  {
                      showModalBottomSheet(
                        useRootNavigator: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        isScrollControlled: true,
                        barrierColor: PjColors.black.withOpacity(0.5),
                        context: context,
                        builder: (ctx) {
                          CbDiaryScreen cubit = BlocProvider.of<CbDiaryScreen>(context);
                          return BottomSheetAddTraining(
                            cubit: cubit,
                            isNewTraining: true,
                            height: 270.h,
                            title: 'Новая тренировка',
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Icon(
                        CustomIcons.plus,
                        size: 24.w,
                        color: PjColors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
            margin: EdgeInsets.only(left: 28.w),
            height: 60.h,
            child: PageView(
              padEnds: false,
              controller: controllerPage,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  days.length,
                  (index) => CalendarItem(
                      isContainsTraining: widget.dateList.contains(DateFormat("yyyy-MM-dd").format(days[index])),
                      date: days[index],
                      selectedDate: context.read<CbDiaryScreen>().currentDate,
                      onItemTap: () {
                        onTapItem(index);
                      })),
            )),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  //Получени индекса тукущего дня
  int getCurrentIndex(DateTime current) {
    int findedIndex = 0;
    for (int i = 0; i < days.length; i++) {
      if (current.year == days[i].year && current.day == days[i].day && current.month == days[i].month) {
        findedIndex = i;
        break;
      }
    }

    return findedIndex - current.weekday + 1;
  }

  /// обработка тапа
  void onTapItem(int index) {
    setState(() {
      context.read<CbDiaryScreen>().currentDate = days[index];
      if (context.read<CbDiaryScreen>().currentDate.day == dateTineNow.day &&
          context.read<CbDiaryScreen>().currentDate.month == dateTineNow.month &&
          context.read<CbDiaryScreen>().currentDate.year == dateTineNow.year) {
        label = 'Сегодня';
      } else {
        label = DateFormat("d MMMM yyyy", 'ru').format(context.read<CbDiaryScreen>().currentDate);
      }
      context
          .read<CbDiaryScreen>()
          .getData(DateFormat("yyyy-MM-dd").format(context.read<CbDiaryScreen>().currentDate), true);
    });
  }

  //Генерация списка дней
  List<DateTime> generateDays() {
    DateTime currentTime = DateTime.now();
    DateTime old = DateTime(currentTime.year - 1, currentTime.month, currentTime.day);
    List<DateTime> localDays = [];
    localDays.add(old);
    for (int i = 1; i < 365 * 2; i++) {
      localDays.add(old.add(Duration(days: i)));
    }
    return localDays;
  }
}
