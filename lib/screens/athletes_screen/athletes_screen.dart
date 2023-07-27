import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlygym/project_utils/pj_icons.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/screens/athletes_screen/widgets/avatar_card.dart';
import 'cubit/cb_athletes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AthletesScreen extends StatefulWidget implements AutoRouteWrapper {
  const AthletesScreen({Key? key}) : super(key: key);

  @override
  State<AthletesScreen> createState() => _AthletesScreenState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbAthletesScreen>(
      create: (context) => CbAthletesScreen()..getData(),
      child: this,
    );
  }
}

class _AthletesScreenState extends State<AthletesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(
        title: 'Атлеты',
        actions: [GestureDetector(onTap: (){}, behavior: HitTestBehavior.translucent, child: Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Icon(CustomIcons.plus, color: Colors.black,),
        ),),]
      ),
      body: BlocConsumer<CbAthletesScreen, StAthletesScreen>(
        listener: (context, state) =>
            state.whenOrNull(error: (code, message) => showAlertDialog(context, message ?? '')),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          loading: () => const PjLoader(),
          loaded: () => _buildBodyContent(context),
        ),
      ),
    );

  }

  Widget _buildBodyContent(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index)=>AvatarCard(callback: (){}), itemCount: 24,);
  }
}
    