import 'package:auto_route/auto_route.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/models/muscle_groups_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

import 'package:onlygym/project_widgets/error_dialog.dart';
import 'package:onlygym/project_widgets/loader_dialog.dart';
import 'package:onlygym/project_widgets/pj_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_loader.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';
import 'package:onlygym/screens/exercises_screen/widgets/button_exercise_list.dart';
import 'package:onlygym/screens/new_exercise_screen/cubit/cb_new_exercise_screen.dart';
import 'package:onlygym/screens/profile_image_screen/widgets/bottom_sheet_photo.dart';

@RoutePage<bool>()
class NewExerciseScreen extends StatefulWidget implements AutoRouteWrapper {
  final int typeExercise;

  const NewExerciseScreen({Key? key, required this.typeExercise}) : super(key: key);

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbNewExerciseScreen>(
      create: (context) => CbNewExerciseScreen()..getData(),
      child: this,
    );
  }
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  String pathToPhoto = "assets/images/exercise.png";
  List<int> selectedGroups = [];
  Color buttonColor = PjColors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: PjColors.white,
        appBar: PjAppBar(
          leading: () {
            context.router.pop();
          },
          title: "Новое упражнение",
        ),
        body: BlocConsumer<CbNewExerciseScreen, StNewExerciseScreen>(
          listener: (context, state) => state.whenOrNull(
              error: (code, message) => showAlertDialog(context, message ?? '', true),
              loading: () => showLoader(context),
              successful: () {
                context.read<CbNewExerciseScreen>().emit(StNewExerciseScreen.init());
                context.router.pop<bool>(true);
              }),
          builder: (context, state) => state.maybeWhen(
            orElse: () => _buildBodyContent(context, context.read<CbNewExerciseScreen>().muscleGroups),
            init: () => const PjLoader(),
            loaded: (muscleGroups) => _buildBodyContent(context, muscleGroups),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, List<MuscleGroupModel> muscleGroups) {
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
          PjTextField(
            title: 'Название упражнения',
            type: PjTextFieldStyle.text,
            controller: controllerTitle,
            onChanged: (v) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          PjTextField(
            onChanged: (v) {
              setState(() {});
            },
            title: 'Описание упражнения',
            type: PjTextFieldStyle.text,
            controller: controllerDescription,
            maxLines: 8,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 42.h,
            child: ListView.builder(
              itemCount: muscleGroups.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ButtonExerciseList(
                  isActive: selectedGroups.contains(index + 1),
                  index: index,
                  callback: () {
                    setState(() {
                      if (selectedGroups.isEmpty || !selectedGroups.contains(index + 1)) {
                        selectedGroups.add(index + 1);
                      } else if (selectedGroups.contains(index + 1)) {
                        selectedGroups.remove(index + 1);
                      }
                    });
                  },
                  text: muscleGroups[index].name!,
                );
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          PjFilledButton(
              buttonColor:
                  controllerTitle.text.isNotEmpty && selectedGroups.isNotEmpty && controllerDescription.text.isNotEmpty
                      ? PjColors.neonBlue
                      : PjColors.white,
              text: 'Добавить упражнение',
              onPressed:
                  selectedGroups.isNotEmpty && controllerTitle.text.isNotEmpty && controllerDescription.text.isNotEmpty
                      ? () {
                          context.read<CbNewExerciseScreen>().createNewExercise(
                              name: controllerTitle.text,
                              description: controllerDescription.text,
                              typeExercise: widget.typeExercise,
                              groupsList: selectedGroups,
                              namePhoto: pathToPhoto.split('/').last,
                              pathPhoto: pathToPhoto);
                        }
                      : () {})
        ],
      ),
    );
  }
}
