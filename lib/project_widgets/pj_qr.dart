import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PjQR extends StatelessWidget {
  const PjQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: 'user_from=12345;user_to=54321',
      gapless: false,
      version: QrVersions.auto,
      size: 128.w,
      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle, color: PjColors.neonBlue),
      dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle, color: PjColors.neonBlue),

    );
  }
}
