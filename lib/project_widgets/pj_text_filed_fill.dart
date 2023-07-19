import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';

class PjTextFieldFill extends StatefulWidget {
  PjTextFieldFill(
      {Key? key, this.onTap, this.onChange,  required this.title, required this.controller, this.isPassword = false})
      : super(key: key);

  final bool isPassword;
  final Function()? onTap;
  final Function(String text)? onChange;
  String title;
  final TextEditingController controller;

  @override
  State<PjTextFieldFill> createState() => _PjTextFieldFillState();
}

class _PjTextFieldFillState extends State<PjTextFieldFill> {
  late bool isShow;
  bool _isTextCentered = true;
  bool isSubmitted = false;

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
        onTapOutside: (event) {
          if (widget.controller.text.isNotEmpty && widget.controller.text != 'Другое') {
            setState(() {
              FocusScope.of(context).unfocus();
              _isTextCentered = true;
              isSubmitted = true;
            });
          } else {
            setState(() {
              FocusScope.of(context).unfocus();
              _isTextCentered = true;
              isSubmitted = false;
              widget.title = 'Другое';
              widget.controller.text = 'Другое';
            });
          }
        },
        onEditingComplete: () {
          if (widget.controller.text.isNotEmpty && widget.controller.text != 'Другое') {
            setState(() {
              FocusScope.of(context).unfocus();
              _isTextCentered = true;
              isSubmitted = true;
            });
          } else {
            setState(() {
              _isTextCentered = true;
              isSubmitted = false;
              widget.title = 'Другое';
              widget.controller.text = 'Другое';
            });
          }
        },
        onTap: () {
          if (widget.controller.text != 'Другое') {
            setState(() {
              isSubmitted = false;
            });
          }
          setState(() {
            _isTextCentered = false;
            widget.onTap!();
          });
        },
        onChanged: (value) {
          setState(() {
            _isTextCentered = false;
            widget.onChange!(value);
          });
        },
        textAlign: _isTextCentered ? TextAlign.center : TextAlign.start,
        cursorColor: PjColors.neonBlue,
        style: TextStyle(
            fontFamily: "PtRoot",
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
            color: isSubmitted ? PjColors.white : PjColors.black),
        decoration: InputDecoration(
          labelText: widget.title,
          fillColor: PjColors.neonBlue,
          filled: isSubmitted,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          labelStyle:
          TextStyle(fontFamily: "PtRoot", fontSize: 14.h, fontWeight: FontWeight.w500, color: PjColors.gray),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: PjColors.ultraLightBlue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: PjColors.ultraLightBlue)),
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
              : null,
        ),
        controller: widget.controller,
        obscureText: widget.isPassword ? isShow : false,
      ),
    );
  }
}
