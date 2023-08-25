import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class PjAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PjAppBar({Key? key, this.leading, this.title = "", this.actions})
      : super(key: key);

  final Function? leading;
  final String title;
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
      title: PjText(
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
