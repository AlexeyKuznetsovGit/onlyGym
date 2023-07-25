import 'dart:developer';

import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';

class AuthRepository {
  Future<void> registration(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String dateBirthday,
      required double height,
      required double weight,
      required String target,
      String? pathPhoto,
      String? namePhoto}) async {
    var formData = pathPhoto != null
        ? FormData.fromMap({
            'email': email,
            'password': password,
            'first_name': firstName,
            'last_name': lastName,
            'date_birth': dateBirthday,
            'contacts': 'Гена сказал что я могу сюда что угодно вставить',
            'height': height,
            'weight': weight,
            'target': target,
            'avatar': await MultipartFile.fromFile(
              pathPhoto,
              filename: namePhoto,
            )
          })
        : FormData.fromMap({
            'email': email,
            'password': password,
            'first_name': firstName,
            'last_name': lastName,
            'date_birth': dateBirthday,
            'contacts': 'Гена сказал что я могу сюда что угодно вставить',
            'height': height,
            'weight': weight,
            'target': target,
          });
    log(password.toString(), name: 'password');
    Map<String, dynamic> response = await Api.post('register', body: formData, urlIndex: ApiUrls.auth, testMode: true);
    Api.setToken(response['access_token']);
  }

  Future<void> login({required String email, required String password}) async {
    Map<String, dynamic> response =
        await Api.post('sign-in', body: {"email": email, "password": password}, urlIndex: ApiUrls.auth, testMode: true);
    Api.setToken(response['access_token']);
  }

  Future<int> sendCode({required String email}) async {
    Map<String, dynamic> response =
        await Api.post('sendCode', query: {"email": email}, urlIndex: ApiUrls.auth, testMode: true);
    return response['code'];
  }
}
