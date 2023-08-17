import 'dart:io';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

export 'pj_icons.dart';
export 'pj_colors.dart';

///EN
///Add your utilities to this class, or use export
///RU
///Добавляйте свои утилиты в данный класс, или используйте export
class PjUtils {
  static String imageUrl = "http://88.204.74.60:33333";
}

Future<bool> getCameraPermission() async {
  if (Platform.isAndroid) {
    return true;
  }
  var status = await perm.Permission.camera.status;
  if (status.isPermanentlyDenied) {
    perm.openAppSettings();
    return false;
  }
  return true;
}

Future<bool> getGalleryPermission() async {
  if (Platform.isAndroid) {
    return true;
  }
  var status = await perm.Permission.photos.status;
  if (status.isPermanentlyDenied) {
    perm.openAppSettings();
    return false;
  }
  return true;
}

String formatDateToISO(String inputDate) {
  DateFormat inputDateFormat = DateFormat("dd.MM.yyyy");
  DateFormat outputDateFormat = DateFormat("yyyy-MM-dd");

  try {
    DateTime date = inputDateFormat.parseStrict(inputDate);
    String formattedDate = outputDateFormat.format(date);
    return formattedDate;
  } catch (e) {
    print('Ошибка при преобразовании даты: $e');
    return '';
  }
}
