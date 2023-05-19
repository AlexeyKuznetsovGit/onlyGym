import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class SizeInfoCard extends StatefulWidget {
  const SizeInfoCard({Key? key, required this.callback,  this.isLong = false, required this.title, required this.icon, required this.data})
      : super(key: key);

  final Function callback;
  final bool isLong;
  final String title;
  final IconData icon;
  final String data;

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
      onTap: (){
        // @todo: При подключении BS будет доработана логика
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
        width: widget.isLong ? 148.w : 100.w,
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.icon, size: 24.w, color: isActive ? PjColors.white : PjColors.neonBlue,),
                  SizedBox(width: 10.w),
                  PjText(widget.data, style: PjTextStyle.bold, color: isActive ? PjColors.white : PjColors.black,)
                ],
              ),
              SizedBox(height: 10.h,),
              PjText(widget.title, style: PjTextStyle.tiny, color: isActive ? PjColors.white : PjColors.black,)
            ],
          ),
        ),
      ),
    );
  }
}