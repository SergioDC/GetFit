import 'package:get_it/get_it.dart';
import 'package:getfit/common/data/change_notifier_custom.dart';
import 'package:getfit/features/log/log.service.dart';

import 'login.dart';

class LoginViewModel extends ChangeNotifierCustom {
  final login = Login();
  final log = GetIt.instance<LogService>();

  LoginViewModel() {}
}
