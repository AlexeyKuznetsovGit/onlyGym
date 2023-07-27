import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/user_model.dart';

class UserRepository {
  Future<UserModel> getMe() async {
    Map<String, dynamic> response = await Api.get('me', urlIndex: ApiUrls.users, testMode: true, isAuth: true);
    return UserModel.fromJson(response);
  }

}
