import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlygym/project_utils/pj_colors.dart';

class PjLoader extends StatelessWidget {
  const PjLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(color: PjColors.neonBlue,),
    );
  }
}