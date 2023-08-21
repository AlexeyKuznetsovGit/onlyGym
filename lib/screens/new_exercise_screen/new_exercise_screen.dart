import 'package:auto_route/auto_route.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/screens/exercises_screen/cubit/cb_exercises_screen.dart';
import 'package:onlygym/screens/exercises_screen/widgets/button_exercise_list.dart';
import 'package:onlygym/screens/profile_image_screen/widgets/bottom_sheet_photo.dart';

@RoutePage()
class NewExerciseScreen extends StatefulWidget implements AutoRouteWrapper {
  const NewExerciseScreen({Key? key}) : super(key: key);

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbExercisesScreen>(
      create: (context) => CbExercisesScreen()..getData(),
      child: this,
    );
  }
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  List<String> nameGroups = ['Грудь', 'Бицепс', 'Трицепс']; //Дополнять надо будет, мб с бэка подтягивать
  String pathToPhoto = "assets/images/exercise.png";
  List<int> selectedGroups = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PjAppBar(
          leading: () {
            context.router.pop();
          },
          title: "Новое упражнение",
        ),
        body: BlocConsumer<CbExercisesScreen, StExercisesScreen>(
          listener: (context, state) =>
              state.whenOrNull(error: (code, message) => showAlertDialog(context, message ?? '')),
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            init: () => const PjLoader(),
            loaded: () => _buildBodyContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () async {
              String? path = await showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                isScrollControlled: true,
                barrierColor: PjColors.black.withOpacity(0.5),
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetPhotoWidget(
                    title: "Изменение изображения",
                    changePhoto: false,
                  );
                },
              );
              if (path != null) {
                setState(() {
                  pathToPhoto = path;
                });
              }
            },
            child: SizedBox(
              width: 334.w,
              height: 180.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  pathToPhoto,
                  width: 334.w,
                  height: 176.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          PjTextField(title: 'Название упражнения', type: PjTextFieldStyle.text, controller: controllerTitle),
          SizedBox(
            height: 20.h,
          ),
          PjTextField(title: 'Описание упражнения', type: PjTextFieldStyle.text, controller: controllerDescription, maxLines: 8,),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 42.h,
            child: ListView.builder(
              itemCount: nameGroups.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ButtonExerciseList(
                  isActive: selectedGroups.contains(index),
                  index: index,
                  callback: () {
                    setState(() {
                      if (selectedGroups.isEmpty || !selectedGroups.contains(index)) {
                        selectedGroups.add(index);
                      } else if(selectedGroups.contains(index)){
                        selectedGroups.remove(index);
                      }
                    });
                  },
                  text: nameGroups[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
