import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

enum _StatsCardType { dynamic, static, cardio, statdyn }

class _InnerStatsCard extends StatelessWidget {
  const _InnerStatsCard(
      {Key? key, this.isFirst = false, required this.title, required this.data})
      : super(key: key);
  final bool isFirst;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      child: Column(
        children: [
          PjText(data, style: PjTextStyle.bold),
          PjText(
            title,
            style: PjTextStyle.tiny,
            color: PjColors.gray,
          )
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  StatsCard.dynamic({
    Key? key,
    required this.round,
    required this.count,
    required this.weight,
    this.time = 0,
  }) : super(key: key) {
    type = _StatsCardType.dynamic;
  }

  StatsCard.static({
    Key? key,
    required this.round,
    this.count = 0,
    required this.weight,
    required this.time,
  }) : super(key: key) {
    type = _StatsCardType.static;
  }

  StatsCard.cardio({
    Key? key,
    required this.round,
    required this.count,
    this.weight = 0,
    this.time = 0,
  }) : super(key: key) {
    type = _StatsCardType.cardio;
  }

  StatsCard.statdyn(
      {Key? key,
      required this.round,
      required this.count,
      required this.weight,
      required this.time})
      : super(key: key) {
    type = _StatsCardType.statdyn;
  }

  final int round;
  final int count;
  final int weight;
  final int time;
  late _StatsCardType type;

  String _timeFormat(int t){
    int min = t ~/ 60;
    int sec = t % 60;
    return (min < 10 ? "0$min" : "$min") +":"+ (sec < 10 ? "0$sec" : "$sec");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 304.w,
      decoration: BoxDecoration(
        border: Border.all(color: PjColors.lightBlue, width: 1.w),
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _InnerStatsCard(
              isFirst: true,
              title: 'Раунд',
              data: round.toString(),
            ),
            Container(
              width: 1.w,
              height: 30.h,
              color: PjColors.ultraLightBlue,
            ),
            if (type == _StatsCardType.static ||
                type == _StatsCardType.statdyn) ...[
              _InnerStatsCard(
                title: 'Время',
                data: _timeFormat(time),
              ),
              Container(
                width: 1.w,
                height: 30.h,
                color: PjColors.ultraLightBlue,
              ),
            ],

            if (type == _StatsCardType.dynamic ||
                type == _StatsCardType.statdyn || type == _StatsCardType.cardio) ...[
              _InnerStatsCard(
                title: 'Повторы',
                data: count.toString(),
              ),
              if(type != _StatsCardType.cardio)...[
                Container(
                width: 1.w,
                height: 30.h,
                color: PjColors.ultraLightBlue,
              )]
            ],
            if (type == _StatsCardType.dynamic || type == _StatsCardType.static || type == _StatsCardType.statdyn) ...[
              _InnerStatsCard(
                title: 'Вес',
                data: weight.toString(),
              )
            ],
          ],
        ),
      ),
    );
  }
}
