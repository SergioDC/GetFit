import 'package:get_it/get_it.dart';

import '../../common/data/change_notifier_custom.dart';
import '../log/log.service.dart';
import 'login.dart';

class LoginViewModel extends ChangeNotifierCustom {
  final login = Login();
  final log = GetIt.instance<LogService>();

  LoginViewModel();

  void initialize() async {
    setInitializeState();
    await Future.delayed(Duration(seconds: 3));
    setReadyState();
  }
}
