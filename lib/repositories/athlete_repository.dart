import 'package:eticon_api/eticon_api.dart';
import 'package:onlygym/main.dart';
import 'package:onlygym/models/user_model.dart';

class AthleteRepository {
  Future<void> getAll() async {
    Map<String, dynamic> response = await Api.get('', urlIndex: ApiUrls.athlete, testMode: true, isAuth: true);
    return null;
  }
}
