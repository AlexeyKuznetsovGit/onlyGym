import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_widgets/pj_text.dart';

class PjFilledButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const PjFilledButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap(),
      color: PjColors.neonBlue,
      child: PjText(
        text: text,
        style: PjTextStyle.bold,
      ),
    );
  }
}
