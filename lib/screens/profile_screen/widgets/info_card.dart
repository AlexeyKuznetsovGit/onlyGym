import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:onlygym/screens/profile_screen/widgets/bottom_sheet_body_parts.dart';


class InfoCard extends StatefulWidget {
  const InfoCard({Key? key, required this.callback, this.isLong=false, required this.title, required this.data}) : super(key: key);
  final Function callback;
  final bool isLong;
  final String title;
  final String data;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  late bool isActive;

  @override
  void initState() {
    isActive = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        // @todo: При подключении BS будет доработана логика
        setState(() {
          isActive = !isActive;
        });
        await widget.callback();
        setState(() {
          isActive = !isActive;
        });

      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? PjColors.neonBlue : PjColors.ultraLightBlue),
          borderRadius: BorderRadius.circular(20.r),
          color: isActive ? PjColors.neonBlue : PjColors.white,
        ),
        width: widget.isLong ? 334.w : 98.w,
        height: 65.h,
        child: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PjText(widget.title, style: PjTextStyle.tiny, color: isActive ? PjColors.white : PjColors.gray,),
              SizedBox(height: 10.h,),
              PjText(widget.data, style: PjTextStyle.bold, color: isActive ? PjColors.white : PjColors.black,),
            ],
          ),
        ),
      ),
    );
  }
}
