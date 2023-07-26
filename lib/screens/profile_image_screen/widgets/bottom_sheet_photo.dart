import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/pj_utils.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class BottomSheetPhotoWidget extends StatefulWidget {
  final bool deletePhoto;

  BottomSheetPhotoWidget({Key? key, required this.deletePhoto}) : super(key: key);

  @override
  State<BottomSheetPhotoWidget> createState() => _BottomSheetPhotoWidgetState();
}

class _BottomSheetPhotoWidgetState extends State<BottomSheetPhotoWidget> {
  MaterialStatesController firstBtnController = MaterialStatesController();
  MaterialStatesController secondBtnController = MaterialStatesController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 250.h,
        decoration: BoxDecoration(
            color: PjColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.only(right: 16.w),
              height: 42.h,
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CustomIcons.cross,
                        size: 24.w,
                        color: PjColors.black,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: PjText(
                          'Фото',
                          style: PjTextStyle.title,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (!widget.deletePhoto) ...[
              PjLongButton(
                text: 'Сделать снимок',
                icon: CustomIcons.plus,
                controller: firstBtnController,
                onPressed: () async {
                  if (!(await getCameraPermission())) {
                    return;
                  }
                  final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    Navigator.pop(context, image.path);
                    //Get.back(result: image.path);
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              PjLongButton(
                text: 'Выбрать фото',
                icon: CustomIcons.photos,
                controller: secondBtnController,
                onPressed: () async {
                  if (!(await getGalleryPermission())) {
                    return;
                  }
                  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery,);

                  if (image != null) {
                    /*Navigator.pop(context, [image.path]);*/
                    Navigator.of(context).pop(image.path);
                    // Get.back(result: image.path);
                  }
                },
              ),
            ] else ...[
              PjLongButton(
                text: 'Удалить фото',
                icon: CustomIcons.trash,
                controller: firstBtnController,
                onPressed: () {
                  SgAppData.instance.avatar = null;
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              PjLongButton(
                text: 'Отмена',
                icon: CustomIcons.cross,
                controller: secondBtnController,
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
            SizedBox(
              height: 20.h,
            ),

            /*PjFilledButton(
              text: 'Применить изменения',
              onPressed: () {},
            )*/
          ],
        ),
      ),
    );
  }
}
