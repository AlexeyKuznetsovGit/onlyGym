import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_text_field.dart';

class PjSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  PjSearchAppBar({Key? key, required this.controller, required this.onChanged, required this.clearSearchField})
      : super(key: key);
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() clearSearchField;
  final FocusNode node = FocusNode();

  @override
  Size get preferredSize => Size.fromHeight(42.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: PjColors.white,
      automaticallyImplyLeading: false,
      title: Container(
        height: 42.h,
        // margin: EdgeInsets.only(top: 40.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CustomIcons.search,
              size: 24.w,
              color: PjColors.black,
            ),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                node.requestFocus();
              },
              child: Container(
                width: 290.w,
                child: TextFormField(
                  onChanged: onChanged,
                  focusNode: node,
                  controller: controller,
                  cursorColor: PjColors.neonBlue,
                  style: TextStyle(
                    fontFamily: "PtRoot",
                    fontSize: 14.h,
                    fontWeight: FontWeight.w500,
                    color: PjColors.black,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                    labelText: "Поиск...",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        fontFamily: "PtRoot", fontSize: 14.h, fontWeight: FontWeight.w500, color: PjColors.gray),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              onTap: clearSearchField,
              child: Icon(
                CustomIcons.small_cross,
                color: PjColors.gray,
                size: 24.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
