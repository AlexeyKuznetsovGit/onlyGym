import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/user_model.dart';

class AuthRepository {
  Future<int> registration(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String dateBirthday,
      required String height,
      required String weight,
      required String target,
      String? pathPhoto,
      String? namePhoto}) async {
    int code = -1;

    var formData = pathPhoto != null
        ? FormData.fromMap({
            'email': email,
            'password': password,
            'first_name': firstName,
            'last_name': lastName,
            'date_birth': dateBirthday,
            'contacts': '',
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
            'contacts': '',
            'height': height,
            'weight': weight,
            'target': target,
          });

    Map<String, dynamic> response = await Api.post('register', body: formData, urlIndex: ApiUrls.auth, testMode: true);
    code = response['code'];
    return code;
  }
}
