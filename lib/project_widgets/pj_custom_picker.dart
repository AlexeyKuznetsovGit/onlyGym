import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';

class PjCustomPicker extends StatefulWidget {
  PjCustomPicker({Key? key, required this.isTime}) : super(key: key);
  final bool isTime;

  @override
  State<PjCustomPicker> createState() => _PjCustomPickerState();
}

class _PjCustomPickerState extends State<PjCustomPicker> {
  static List<String> times = List<String>.generate(60, (int index) => index.toString());
  static List<String> countRounds = List<String>.generate(10, (int index) => (index + 1).toString());

  final FixedExtentScrollController _toController = FixedExtentScrollController(initialItem: 30);
  final FixedExtentScrollController _fromController = FixedExtentScrollController();
  int currentMinuteIndex = 0;
  int currentSecondIndex = 30;
  int currentCountIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.isTime ? timeDuration() : roundCount();
  }

  Widget roundCount() {
    return SizedBox(
      height: 340.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: () {
              context.router.pop(countRounds[currentCountIndex]);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w, top: 15.h),
              child: Icon(
                CustomIcons.goal,
                size: 24.w,
                color: PjColors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50.w,),
              Container(
                width: 50.w,
                alignment: Alignment.center,
                child: ListWheelScrollView(
                  controller: _fromController,
                  scrollBehavior: CupertinoScrollBehavior(),
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) => {
                    HapticFeedback.lightImpact(),
                    setState(() {
                      currentMinuteIndex = index;
                      if (currentMinuteIndex == 0 && currentSecondIndex == 0) {
                        currentSecondIndex++;
                        _toController.jumpToItem(currentSecondIndex);
                      }
                    }),
                  },
                  itemExtent: 30.w,
                  children: List.generate(
                    countRounds.length,
                        (index) => Text(
                          countRounds[index],
                      style: TextStyle(
                        fontSize: 20.w,
                        letterSpacing: 0.61,
                        fontFamily: 'PtRoot',
                        color: currentCountIndex == index ? PjColors.black : const Color.fromRGBO(137, 137, 140, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 75.w,
                margin: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  getNoun(int.parse(countRounds[currentCountIndex]), 'раунд', 'раунда', 'раундов'),
                  style: TextStyle(
                    fontSize: 20.w,
                    letterSpacing: 0.61,
                    fontFamily: 'PtRoot',
                    color: PjColors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget timeDuration() {
    return SizedBox(
      height: 340.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: () {
              if (currentMinuteIndex < 10 && currentSecondIndex >= 10) {
                context.router.pop("0${times[currentMinuteIndex]}:${times[currentSecondIndex]}");
              } else if (currentSecondIndex < 10 && currentMinuteIndex >= 10) {
                context.router.pop("${times[currentMinuteIndex]}:0${times[currentSecondIndex]}");
              } else if (currentMinuteIndex < 10 && currentSecondIndex < 10) {
                context.router.pop("0${times[currentMinuteIndex]}:0${times[currentSecondIndex]}");
              } else {
                context.router.pop("${times[currentMinuteIndex]}:${times[currentSecondIndex]}");
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w, top: 15.h),
              child: Icon(
                CustomIcons.goal,
                size: 24.w,
                color: PjColors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100.w,
              ),
              Container(
                width: 50.w,
                alignment: Alignment.center,
                child: ListWheelScrollView(
                  controller: _fromController,
                  scrollBehavior: CupertinoScrollBehavior(),
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) => {
                    HapticFeedback.lightImpact(),
                    setState(() {
                      currentMinuteIndex = index;
                      if (currentMinuteIndex == 0 && currentSecondIndex == 0) {
                        currentSecondIndex++;
                        _toController.jumpToItem(currentSecondIndex);
                      }
                    }),
                  },
                  itemExtent: 30.w,
                  children: List.generate(
                    times.length,
                    (index) => Text(
                      index < 10 ? "0${times[index]}" : times[index],
                      style: TextStyle(
                        fontSize: 20.w,
                        letterSpacing: 0.61,
                        fontFamily: 'PtRoot',
                        color: currentMinuteIndex == index ? PjColors.black : const Color.fromRGBO(137, 137, 140, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 75.w,
                margin: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  getNoun(int.parse(times[currentMinuteIndex]), 'минута', 'минуты', 'минут'),
                  style: TextStyle(
                    fontSize: 20.w,
                    letterSpacing: 0.61,
                    fontFamily: 'PtRoot',
                    color: PjColors.black,
                  ),
                ),
              ),
              Container(
                width: 50.w,
                alignment: Alignment.center,
                child: ListWheelScrollView(
                  controller: _toController,
                  scrollBehavior: CupertinoScrollBehavior(),
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) => {
                    HapticFeedback.lightImpact(),
                    setState(() {
                      currentSecondIndex = index;
                      if (currentMinuteIndex == 0 && currentSecondIndex == 0) {
                        currentSecondIndex++;
                        _toController.jumpToItem(currentSecondIndex);
                      }
                    }),
                  },
                  itemExtent: 30.w,
                  children: List.generate(
                    times.length,
                    (index) => Text(
                      index < 10 ? "0${times[index]}" : times[index],
                      style: TextStyle(
                        fontSize: 20.w,
                        letterSpacing: 0.61,
                        fontFamily: 'PtRoot',
                        color: currentSecondIndex == index ? PjColors.black : const Color.fromRGBO(137, 137, 140, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 85.w,
                margin: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  getNoun(int.parse(times[currentSecondIndex]), 'секунда', 'секунды', 'секунд'),
                  style: TextStyle(
                    fontSize: 20.w,
                    letterSpacing: 0.61,
                    fontFamily: 'PtRoot',
                    color: PjColors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getNoun(int number, String one, String two, String five) {
    int n = (number).abs();
    n %= 100;
    if (n >= 5 && n <= 20) {
      return five;
    }
    n %= 10;
    if (n == 1) {
      return one;
    }
    if (n >= 2 && n <= 4) {
      return two;
    }
    return five;
  }
}
