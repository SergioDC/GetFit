import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'login.viewmodel.dart';

class LoginViewReady extends StatelessWidget {
  const LoginViewReady({super.key});

  @override
  Widget build(BuildContext context) {
    var loginViewModel = GetIt.instance<LoginViewModel>();

    if (loginViewModel.login.hasLoginProfile) {
      return Center(child: Text('READY WITH PROFILE'));
    } else {
      return Center(child: Text('READY WITHOUT PROFILE'));
    }
  }
}
