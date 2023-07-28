import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_body_parts.dart';

class SizeInfoCard extends StatefulWidget {
  const SizeInfoCard(
      {Key? key,
      required this.callback,
      this.isLong = false,
      required this.title,
      required this.icon,
        required this.cubit,
        this.athleteId,
        required this.idParam,
      required this.data})
      : super(key: key);

  final Function callback;
  final CbProfileScreen cubit;
  final bool isLong;
  final String title;
  final IconData icon;
  final String data;
  final int idParam;
  final int? athleteId;

  @override
  State<SizeInfoCard> createState() => _SizeInfoCardState();
}

class _SizeInfoCardState extends State<SizeInfoCard> {
  late bool isActive;

  @override
  void initState() {
    isActive = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // @todo: При подключении BS будет доработана логика
        setState(() {
          isActive = !isActive;
        });
        await showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          isScrollControlled: true,
          barrierColor: PjColors.black.withOpacity(0.5),
          context: context,
          builder: (BuildContext context) {
            return BottomSheetBodyPartsWidget(
              athleteId: widget.athleteId,
              idParam: widget.idParam,
              cubit: widget.cubit,
              data: widget.data,
              title: widget.title,
              height: 270.h,
              type: BottomSheetType.init,
            );
          },
        );
        setState(() {
          isActive = !isActive;
        });
        widget.callback();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? PjColors.neonBlue : PjColors.ultraLightBlue),
          borderRadius: BorderRadius.circular(20.r),
          color: isActive ? PjColors.neonBlue : PjColors.white,
        ),
        width: widget.isLong ? 147.w : 94.w,
        height: 72.h,
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    size: 24.w,
                    color: isActive ? PjColors.white : PjColors.neonBlue,
                  ),
                  SizedBox(width: 10.w),
                  PjText(
                    widget.data,
                    style: PjTextStyle.bold,
                    color: isActive ? PjColors.white : PjColors.black,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              PjText(
                widget.title,
                style: PjTextStyle.tiny,
                color: isActive ? PjColors.white : PjColors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
