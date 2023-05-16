import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'cubit/cb_timer_screen.dart';
import 'cubit/st_timer_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(),
      body: BlocBuilder<CbTimerScreen, StTimerScreen>(
        builder: (context, state){
          if(state is StTimerScreenLoading){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is StTimerScreenLoaded){
            return Container(color: Colors.green);
          }
          if(state is StTimerScreenError){
            return Container(color: Colors.red);
          }
          return Container(color: Colors.grey);
        },
      ),
    );
      
  }
}
    