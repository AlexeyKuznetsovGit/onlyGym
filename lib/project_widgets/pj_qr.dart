import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PjQR extends StatelessWidget {
  const PjQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: SgAppData.instance.user.id.toString(),
      gapless: false,
      version: QrVersions.auto,
      size: 128.w,
      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle, color: PjColors.neonBlue),
      dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle, color: PjColors.neonBlue),

    );
  }
}
