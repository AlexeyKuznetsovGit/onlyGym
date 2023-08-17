import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlygym/project_utils/pj_colors.dart';
import 'package:onlygym/project_utils/pj_icons_n.dart';
import 'package:onlygym/project_utils/singletons/sg_app_data.dart';
import 'package:onlygym/project_widgets/pj_buttons/pj_long_button.dart';
import 'package:onlygym/project_widgets/pj_text.dart';
import 'package:onlygym/router/router.dart';
import 'package:onlygym/screens/athletes_screen/cubit/cb_athletes_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BottomSheetAddAthelet extends StatefulWidget {
  final String title;
  final double height;
  final bool isQr;
  final CbAthletesScreen cubit;

  const BottomSheetAddAthelet(
      {Key? key, required this.title, required this.cubit, required this.height, this.isQr = false})
      : super(key: key);

  @override
  State<BottomSheetAddAthelet> createState() => _BottomSheetAddAtheletState();
}

class _BottomSheetAddAtheletState extends State<BottomSheetAddAthelet> {
  /*Set<MaterialState> changeButtonState = {MaterialState.selected};
  Set<MaterialState> statisticsButtonState = {MaterialState.selected};*/

  MaterialStatesController changeController = MaterialStatesController();
  MaterialStatesController statisticsController = MaterialStatesController();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
              color: PjColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              boxShadow: [BoxShadow(color: PjColors.black.withOpacity(0.2), blurRadius: 8.r, offset: Offset(0, 2))]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.only(right: 16.w),
                height: 42.h,
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CustomIcons.cross,
                          size: 24.w,
                          color: PjColors.black,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: PjText(
                            widget.title,
                            style: PjTextStyle.title,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              if (widget.isQr) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SizedBox(
                    height: 334.w,
                    width: 334.w,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
              ] else ...[
                PjLongButton(
                  onPressed: () {
                    context.router.push(CreateNewAthleteRoute());
                    // showModalBottomSheet(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(20.r),
                    //       topRight: Radius.circular(20.r),
                    //     ),
                    //   ),
                    //   isScrollControlled: true,
                    //   barrierColor: PjColors.black.withOpacity(0.5),
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return BottomSheetAddAthelet(
                    //       height: 342.h,
                    //       title: widget.title,
                    //       type: BottomSheetType.edit,
                    //     );
                    //   },
                    // );
                  },
                  text: 'Создать нового атлета',
                  icon: CustomIcons.plus,
                  controller: changeController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PjLongButton(
                  onPressed: () {
                    showModalBottomSheet(
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
                        return BottomSheetAddAthelet(
                          cubit: widget.cubit,
                          height: 480.h,
                          title: 'Поместите QR-код в рамку',
                          isQr: true,
                        );
                      },
                    );
                  },
                  text: 'Приобрести доступ к аккаунту',
                  icon: CustomIcons.qr,
                  controller: statisticsController,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.format == BarcodeFormat.qrcode && scanData.code != null) {
        if (scanData.code!.isNotEmpty &&
            isNumeric(scanData.code!) &&
            scanData.code != SgAppData.instance.user.id.toString() &&
            !widget.cubit.athletesId.contains(scanData.code)) {
          controller.stopCamera();
          log(scanData.code!, name: "QR-code DATA");
          await widget.cubit.addAthleteByQr(int.parse(scanData.code!));
          context.router.pop();
          context.router.pop();
        }
      }
    });
  }

  bool isNumeric(String str) {
    return num.tryParse(str) != null;
  }
}
