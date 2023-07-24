
import 'dart:io';
import 'package:permission_handler/permission_handler.dart' as perm;

export 'pj_icons.dart';
export 'pj_colors.dart';
///EN
///Add your utilities to this class, or use export
///RU
///Добавляйте свои утилиты в данный класс, или используйте export
class PjUtils{
 static bool offBarrierColor = false;
}
Future<bool> getCameraPermission()async{
 if(Platform.isAndroid){
  return true;
 }
 var status = await perm.Permission.camera.status;
 if(status.isPermanentlyDenied){
  perm.openAppSettings();
  return false;
 }
 return true;
}

Future<bool> getGalleryPermission()async{
 if(Platform.isAndroid){
  return true;
 }
 var status = await perm.Permission.photos.status;
 if(status.isPermanentlyDenied){
  perm.openAppSettings();
  return false;
 }
 return true;
}
  