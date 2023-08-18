import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class PjAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PjAppBar({Key? key, this.leading, this.title = "", this.actions, this.searchTitle})
      : super(key: key);

  final Function? leading;
  final String title;
  final Widget? searchTitle;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(42.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: PjColors.white,
      automaticallyImplyLeading: false,
      title: searchTitle ?? PjText(
        title,
        style: PjTextStyle.title,
      ),
      actions: actions,
      leading: leading != null
          ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                leading!();
              },
              child: Icon(
                CustomIcons.back,
                color: PjColors.black,
              ),
            )
          : null,
    );
  }
}

class PjSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  PjSearchAppBar({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      color: PjColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
        ),
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
              onTap: (){
                node.requestFocus();
              },
              child: Container(
                width: 290.w,
                child: TextField(
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
                    labelText: "Поиск...",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        fontFamily: "PtRoot",
                        fontSize: 14.h,
                        fontWeight: FontWeight.w500,
                        color: PjColors.gray
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(4.w),
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

  @override
  Size get preferredSize => Size.fromHeight(42.h);
}
