import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_filled_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';

class BottomSheetEditingWidget extends StatefulWidget {
  BottomSheetEditingWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetEditingWidget> createState() => _BottomSheetEditingWidgetState();
}

class _BottomSheetEditingWidgetState extends State<BottomSheetEditingWidget> {
  List<String> data = ['Вадим', 'Казаков', 'sniperaft@bk.ru', '25.04.2023', '64 кг', '179 см'];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    // TODO: implement initState
    controllers = generateTextEditingControllers(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 630.h,
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
                          'Редактирование',
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
            ...List.generate(
                6,
                (index) => Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: PjTextField(
                        type: PjTextFieldStyle.text,
                        title: data[index],
                        controller: controllers[index],
                      ),
                    )),
            PjFilledButton(
              text: 'Применить изменения',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  List<TextEditingController> generateTextEditingControllers(List<String> data) {
    return List<TextEditingController>.generate(6, (index) => TextEditingController(text: data[index]));
  }
}
