import 'models/login.profile.dart';

class LoginRepository {
  //TODO: remove mock getLoginProfile
  static Future<LoginProfile?> getLoginProfile() async {
    await Future.delayed(Duration(seconds: 3));
    return LoginProfile(name: 'MockUsername');
    //return null;
  }
}
