import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';

class EmptyAvatar extends StatelessWidget {
  const EmptyAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Icon(
          CustomIcons.avatar,
          size: 98.w,
          color: PjColors.neonBlue,
        ),
        Container(
          width: 24.w,
          height: 24.h,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: PjColors.lightBlue),
          child: const Icon(
            CustomIcons.plus_small,
            color: PjColors.white,
          ),
        )
      ],
    );
  }
}
