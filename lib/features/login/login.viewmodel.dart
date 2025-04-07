import 'package:get_it/get_it.dart';

import '../../common/data/change_notifier_custom.dart';
import '../log/log.service.dart';
import 'login.dart';
import 'login.service.dart';
import 'models/login.profile.dart';

class LoginViewModel extends ChangeNotifierCustom {
  final login = Login();
  final log = GetIt.instance<LogService>();
  LoginProfile? loginProfile;

  LoginViewModel();

  void initialize() async {
    setInitializeState();

    try {
      loginProfile = await LoginService.getLoginProfile();
      if (loginProfile == null) {
        login.hasLoginProfile = false;
      } else {
        login.hasLoginProfile = true;
      }

      setReadyState();
    } catch (e) {
      setErrorState(e.toString());
    }
  }

  void createNewLoginProfile(String name, String password) async {}
  void logIntoLoginProfile(String name, String password) async {}
}
