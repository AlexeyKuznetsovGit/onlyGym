
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlygym/models/user_model.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class AvatarCard extends StatefulWidget {
  final Function callback;
  final bool isChoiceAthlete;
  final UserModel user;

  const AvatarCard({Key? key, required this.callback, this.isChoiceAthlete = false, required this.user}) : super(key: key);

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  late bool isTouch;

  @override
  void initState() {
    isTouch = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){widget.callback();},
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 334.w,
        decoration: BoxDecoration(
          border: Border.all(color: PjColors.ultraLightBlue, width: 1.w),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: SizedBox(
          width: 334.w,
          child: Row(
            children: [

              Padding(
                padding:  EdgeInsets.only(left: 15.w, top: 15.h,bottom: 15.h),
                child: Icon(CustomIcons.avatar, size: 54.w, color: PjColors.neonBlue,),
              ),
              SizedBox(width: 10.w,),
              SizedBox(
                width: 228.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    PjText('${widget.user.firstName} ${widget.user.lastName}', style: PjTextStyle.bold, color: isTouch ? PjColors.gray : PjColors.black),
                    SizedBox(height: 10.h,),
                    Container(child: PjText(widget.user.goal ?? "Улучшение формы", style: PjTextStyle.regular, color: isTouch ? PjColors.lightGray : PjColors.gray)),
                  ],
                ),
              ),
              const Spacer(),
              if(widget.isChoiceAthlete)...[
                Icon(CustomIcons.plus_small, color: isTouch ? PjColors.ultraLightBlue : PjColors.lightBlue, size: 24.w,),
              ],
              SizedBox(width: 10.w,)
            ],
          ),
        ),
      ),
    );
  }
}
