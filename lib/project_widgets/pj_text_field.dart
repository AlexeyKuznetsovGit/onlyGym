import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';

class PjTextField extends StatefulWidget {
  const PjTextField(
      {Key? key,
      required this.title,
      required this.controller,
      this.isPassword = false})
      : super(key: key);

  final bool isPassword;
  final String title;
  final TextEditingController controller;

  @override
  State<PjTextField> createState() => _PjTextFieldState();
}

class _PjTextFieldState extends State<PjTextField> {
  late bool isShow;

  @override
  void initState() {
    isShow = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334.w,
      child: TextField(
        cursorColor: PjColors.neonBlue,
        style: TextStyle(
            fontFamily: "PtRoot",
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
            color: PjColors.black
        ),
        decoration: InputDecoration(
          labelText: widget.title,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          labelStyle: TextStyle(
            fontFamily: "PtRoot",
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
            color: PjColors.gray
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: PjColors.ultraLightBlue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: PjColors.ultraLightBlue)),
          contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Icon(
                    isShow ? CustomIcons.show : CustomIcons.hide,
                    color: PjColors.lightBlue,
                  ),
                )
              : SizedBox(),
        ),
        controller: widget.controller,
        obscureText: widget.isPassword ? isShow : false,
      ),
    );
  }
}
