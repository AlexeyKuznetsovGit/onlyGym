import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';

class EmptyAvatar extends StatelessWidget {
  final int? athleteId;

  const EmptyAvatar({
    this.athleteId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Icon(
          athleteId != null ? CustomIcons.avatar : SgAppData.instance.localAvatar,
          // Потому что не знаем какой локальный аватар выбран
          size: 98.w,
          color: PjColors.neonBlue,
        ),
        if (athleteId == null) ...[
          Container(
            width: 24.w,
            height: 24.h,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: PjColors.lightBlue),
            child: const Icon(
              CustomIcons.plus_small,
              color: PjColors.white,
            ),
          )
        ]
      ],
    );
  }
}
