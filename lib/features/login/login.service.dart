import 'package:getfit/features/login/login.repository.dart';

import 'models/login.profile.dart';

class LoginService {
  static Future<LoginProfile?> getLoginProfile() async {
    var loginProfile = await LoginRepository.getLoginProfile();
    return loginProfile;
  }
}
