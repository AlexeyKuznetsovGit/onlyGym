import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_qr.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class BottomSheetQrWidget extends StatelessWidget {
  const BottomSheetQrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 274.h,
      decoration: BoxDecoration(
          color: PjColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.only(right: 16.w),
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
                      padding:  EdgeInsets.only(left: 16.w),
                      child: PjText(
                        'Ваш QR-код',
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
          PjQR()
        ],
      ),
    );
  }
}
