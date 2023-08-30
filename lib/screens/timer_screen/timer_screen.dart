import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'cubit/cb_timer_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TimerScreen extends StatefulWidget implements AutoRouteWrapper {
  const TimerScreen({Key? key}) : super(key: key);
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbTimerScreen>(
      create: (context) => CbTimerScreen(),
      child: this,
    );
  }
  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(title: 'Таймер', leading: (){
        context.router.pop();
      },),
      body: BlocConsumer<CbTimerScreen, StTimerScreen>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
          );
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
    return Column();
  }
}
    