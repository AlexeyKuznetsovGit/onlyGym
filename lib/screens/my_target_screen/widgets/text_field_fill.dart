import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/screens/my_target_screen/cubit/cb_my_target_screen.dart';

class TextFieldFill extends StatefulWidget {
  TextFieldFill(
      {Key? key,
      this.onTap,
      required this.selectedOption,
      this.onChange,
      required this.title,
      required this.controller,
      this.isPassword = false})
      : super(key: key);

  final bool isPassword;
  final Function()? onTap;
  final Function(String text)? onChange;
  final String title;
  final TextEditingController controller;
  final String selectedOption;

  @override
  State<TextFieldFill> createState() => _TextFieldFillState();
}

class _TextFieldFillState extends State<TextFieldFill> {
  late bool isShow;
  bool _isTextCentered = true;

  @override
  void initState() {
    isShow = false;
    super.initState();
  }

  //Todo Если сделать без использования конкретного кубита, то можно вынести в PjWidgets

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334.w,
      child: TextField(
        onTapOutside: (event) {
          if (widget.controller.text.isNotEmpty &&
              widget.controller.text != 'Другое' &&
              widget.selectedOption == widget.controller.text) {
            setState(() {
              FocusScope.of(context).unfocus();
              _isTextCentered = true;
              context.read<CbMyTargetScreen>().isSubmitted = true;
            });
          } else {
            setState(() {
              FocusScope.of(context).unfocus();
              _isTextCentered = true;
              context.read<CbMyTargetScreen>().isSubmitted = false;
              /* widget.title = 'Другое';
              widget.controller.text = 'Другое';*/
            });
          }
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          if (widget.controller.text.isNotEmpty && widget.controller.text != 'Другое') {
            setState(() {
              _isTextCentered = true;
              context.read<CbMyTargetScreen>().isSubmitted = true;
            });
          } else {
            setState(() {
              _isTextCentered = true;
              context.read<CbMyTargetScreen>().isSubmitted = false;
              /*widget.title = 'Другое';
              widget.controller.text = 'Другое';*/
            });
          }
        },
        onTap: () {
          if (widget.controller.text != 'Другое') {
            setState(() {
              context.read<CbMyTargetScreen>().isSubmitted = false;
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
            color: context.read<CbMyTargetScreen>().isSubmitted ? PjColors.white : PjColors.black),
        decoration: InputDecoration(
          labelText: widget.title,
          fillColor: PjColors.neonBlue,
          filled: context.read<CbMyTargetScreen>().isSubmitted,
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
