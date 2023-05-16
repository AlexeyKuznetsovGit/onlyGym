import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'cubit/cb_diary_screen.dart';
import 'cubit/st_diary_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
      

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(),
      body: BlocBuilder<CbDiaryScreen, StDiaryScreen>(
        builder: (context, state){
          if(state is StDiaryScreenLoading){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is StDiaryScreenLoaded){
            return Container(color: Colors.green);
          }
          if(state is StDiaryScreenError){
            return Container(color: Colors.red);
          }
          return Container(color: Colors.grey);
        },
      ),
    );
      
  }
}
    