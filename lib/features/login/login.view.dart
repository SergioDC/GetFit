import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../common/data/change_notifier_custom.dart';
import '../settings/settings.viewmodel.dart';
import 'login.view.error.dart';
import 'login.view.initializing.dart';
import 'login.view.loading.dart';
import 'login.view.ready.dart';
import 'login.viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeLogin();
    });
  }

  void initializeLogin() async {
    var loginViewModel = GetIt.instance<LoginViewModel>();
    var settingsViewModel = GetIt.instance<SettingsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: initial UI -> obtaining user profile
    //TODO: no profile -> create new user
    //TODO: profile found -> download user data

    return Consumer<LoginViewModel>(
      builder: (_, loginViewModel, __) {
        switch (loginViewModel.state) {
          case NotifierState.initilializing:
            return LoginViewInitializing();
          case NotifierState.error:
            return LoginViewError();
          case NotifierState.loading:
            return LoginViewLoading();
          case NotifierState.ready:
            return LoginViewReady();
        }
      },
    );
  }
}
