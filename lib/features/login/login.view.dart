// We import necessary libraries to build the LoginView widget and manage dependency injection and state changes.
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// We import view models and various login view states to facilitate state-specific UI rendering.
import '../../common/data/change_notifier_custom.dart';
import '../settings/settings.viewmodel.dart';
import 'login.view.error.dart';
import 'login.view.initializing.dart';
import 'login.view.loading.dart';
import 'login.view.ready.dart';
import 'login.viewmodel.dart';
import '../log/log.service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  // We provide a stateful widget to allow dynamic updates based on login state changes,
  // which is critical for responsive UI transitions during login initialization.
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();

    // We schedule login initialization after the first frame to ensure the UI is rendered before heavy processing begins.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeLogin();
    });
  }

  // We perform login initialization asynchronously to avoid blocking the UI thread,
  // ensuring a smoother user experience during startup.
  void initializeLogin() async {
    // We retrieve the LoginViewModel via dependency injection to centralize login state management.
    var loginViewModel = GetIt.instance<LoginViewModel>();
    // We log the LoginViewModel instance to trace dependency resolution for debugging purposes.
    GetIt.instance<LogService>().logData(
      'LoginViewModel obtained',
      loginViewModel,
    );

    // We retrieve the SettingsViewModel to access global application settings required during login.
    var settingsViewModel = GetIt.instance<SettingsViewModel>();
    // We log the SettingsViewModel instance to confirm configuration values are available for the login process.
    GetIt.instance<LogService>().logData(
      'SettingsViewModel obtained',
      settingsViewModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use Consumer to rebuild the UI based on LoginViewModel state changes,
    // which allows us to dynamically switch between different login UI views.
    return Consumer<LoginViewModel>(
      builder: (_, loginViewModel, __) {
        // We use a switch-case structure to return the appropriate view based on the current state,
        // ensuring that the user is presented with the correct UI corresponding to the login process phase.
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
