import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_input_formatter.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:regexed_validator/regexed_validator.dart';

enum PjTextFieldStyle {
  password,
  email,
  date,
  text,
  number,
  params,
  time,
}

class PjTextField extends StatefulWidget {
  const PjTextField(
      {Key? key,
      required this.title,
      this.onChanged,
      required this.type,
      this.repeatPassword = '',
      required this.controller,
      this.suffixText,
      this.checkCode,
      this.enabled = true,
      this.maxLines = 1})
      : super(key: key);

  final PjTextFieldStyle type;
  final int? checkCode;
  final Function(String)? onChanged;
  final String title;
  final String repeatPassword;
  final TextEditingController controller;
  final String? suffixText;
  final int? maxLines;
  final bool enabled;

  @override
  State<PjTextField> createState() => _PjTextFieldState();
}

class _PjTextFieldState extends State<PjTextField> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334.w,
      child: TextFormField(
        enabled: widget.enabled,
        textCapitalization:
            widget.type == PjTextFieldStyle.text ? TextCapitalization.sentences : TextCapitalization.none,
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        // maxLength: 40, //Если вводить больше символов, то появляется отступ который на половину перекрывает текст
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.email && !GetUtils.isEmail(value)) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.password &&
              widget.repeatPassword.isNotEmpty &&
              (value.length < 6 || value != widget.repeatPassword)) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.password && widget.repeatPassword.isEmpty && value.length < 6) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.date && !_validateDate(value)) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.time && !_validateTime(value)) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.params && (value == '0' || value == '0.0' || value.endsWith('.'))) {
            return '';
          }
          if (widget.type == PjTextFieldStyle.number &&
              (widget.checkCode != null && widget.checkCode != int.parse(widget.controller.text))) {
            return '';
          }
        },
        cursorColor: PjColors.neonBlue,
        inputFormatters: widget.type == PjTextFieldStyle.date
            ? [
                DateTextFormatter(),
              ]
            : widget.type == PjTextFieldStyle.params
                ? [
                    DecimalInputFormatter(),
                    //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : widget.type == PjTextFieldStyle.time
                    ? [
                        TimeTextFormatter(),
                        //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ]
                    : null,
        keyboardType: getTextInputType(widget.type),
        style: TextStyle(fontFamily: "PtRoot", fontSize: 14.h, fontWeight: FontWeight.w500, color: PjColors.black),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          suffixText: widget.suffixText,
          suffixStyle:
              TextStyle(fontFamily: "PtRoot", fontSize: 14.h, fontWeight: FontWeight.w500, color: PjColors.black),
          errorStyle: TextStyle(height: 0, color: Colors.transparent),
          isCollapsed: true,
          labelText: widget.title,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          labelStyle:
              TextStyle(fontFamily: "PtRoot", fontSize: 14.h, fontWeight: FontWeight.w500, color: PjColors.gray),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: PjColors.ultraLightBlue)),
          focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: PjColors.ultraLightBlue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r), borderSide: BorderSide(color: PjColors.ultraLightBlue)),
          contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          suffixIcon: widget.type == PjTextFieldStyle.password
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
        obscureText: widget.type == PjTextFieldStyle.password ? isShow : false,
      ),
    );
  }

  TextInputType getTextInputType(PjTextFieldStyle type) {
    switch (type) {
      case PjTextFieldStyle.number:
        return TextInputType.number;
      case PjTextFieldStyle.email:
        return TextInputType.emailAddress;
      case PjTextFieldStyle.date:
        return TextInputType.number;
      case PjTextFieldStyle.params:
        return TextInputType.datetime;
      case PjTextFieldStyle.time:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  bool _validateTime(String input) {
    if (validator.time(input)) {
      return true;
    } else {
      return false;
    }
  }

  bool _validateDate(String date) {
    DateFormat _dateFormat = DateFormat("dd.MM.yyyy");
    try {
      DateTime parsedDate = _dateFormat.parseLoose(date);

      // Проверяем, что год рождения не позднее 1900
      if (parsedDate.year >= 1900) {
        if (parsedDate.isBefore(DateTime.now())) {
          return true; // Дата в прошлом или настоящем - допустимая дата рождения
        } else {
          return false; // Дата рождения должна быть в прошлом
        }
      } else {
        return false; // Недопустимый год рождения
      }
    } catch (e) {
      return false; // Некорректный формат даты
    }
  }
}
