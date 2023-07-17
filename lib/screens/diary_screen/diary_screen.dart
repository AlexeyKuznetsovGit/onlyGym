import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
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
      create: (context) => CbDiaryScreen()..getData(),
      child: this,
    );
  }
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(),
      body: BlocConsumer<CbDiaryScreen, StDiaryScreen>(
        listener: (context, state) {
          state.maybeWhen(orElse: (){}, error: (code,message){
            showAlertDialog(context, message!);
          });
        },
        builder: (context, state) => state.maybeWhen(
          orElse: ()=> Container(),
          loading: () => const PjLoader(),
          loaded: () => _buildBodyContent(context),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Center(
      child: Text('Diary'),
    );
  }
}
