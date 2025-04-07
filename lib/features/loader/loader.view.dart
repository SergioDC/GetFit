import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:getfit/common/extensions/context_extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../common/data/change_notifier_custom.dart';
import '../../common/style/background_cover.dart';
import '../../common/widgets/bordered_text.dart';
import '../../common/widgets/loading_placeholder.dart';
import '../log/log.service.dart';
import '../login/login.view.dart';
import '../settings/settings.viewmodel.dart';
import 'loader.view.anim.dart';
import 'loader.viewmodel.dart';

class LoaderView extends StatefulWidget {
  const LoaderView({super.key});

  // We provide a standard route creation method to ensure consistent navigation transitions.
  static MaterialPageRoute route() {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => const LoaderView(),
    );
  }

  @override
  State<LoaderView> createState() => _LoaderState();
}

class _LoaderState extends State<LoaderView> with TickerProviderStateMixin {
  // We acquire the LogService instance to ensure logging consistency within this view.
  final log = GetIt.instance<LogService>();
  // We declare a LoaderViewAnim instance to manage and coordinate UI animations during the loading process.
  late LoaderViewAnim loaderViewAnim;

  @override
  void initState() {
    super.initState();

    // Instantiate the animation controller, providing a ticker and a callback to refresh the UI during animations.
    loaderViewAnim = LoaderViewAnim(
      tickerProvider: this,
      onSetState: refreshAnimatedUI,
    );
    log.logData('LoaderViewAnim instance created', loaderViewAnim);

    // Schedule app initialization after the first frame to ensure the UI is built before heavy processing starts.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeLoader();
    });
  }

  // We use this callback to trigger UI refreshes in response to animation state changes.
  void refreshAnimatedUI() {
    setState(() {});
  }

  // This asynchronous method coordinates the initialization of application data and transitions between loading stages.
  Future<void> initializeLoader() async {
    // Start the initial loading animation to provide immediate visual feedback to the user.
    loaderViewAnim.controllerStart.forward();

    // Wait until the log service signals readiness to ensure that all logging operations will be captured.
    while (!log.isReady) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    // Retrieve package information to label the app version; useful for debugging and user support.
    var info = await PackageInfo.fromPlatform();
    log.logData('Retrieved PackageInfo', info);

    // Acquire the SettingsViewModel instance to update the UI with version information.
    var settingsViewModel = GetIt.instance<SettingsViewModel>();
    log.logData('Acquired SettingsViewModel instance', settingsViewModel);
    // Update version label so that users can see the current version and build number.
    settingsViewModel.versionLabel =
        '${info.appName} ${info.version}+${info.buildNumber}';

    // Acquire the LoaderViewModel instance to start loading application data.
    var loaderViewModel = GetIt.instance<LoaderViewModel>();
    log.logData('Acquired LoaderViewModel instance', loaderViewModel);
    // Log the initiation of data loading to capture the start of the critical loading phase.
    log.logInfo('Initializing application data.');
    await loaderViewModel.initializeAppData(context);
    log.logInfo('Application data is ready. Redirecting to main route.');

    // Ensure that the LoaderViewModel has reached a ready state before proceeding.
    log.logInfo('Waiting for LoaderViewModel to finish loading.');
    await loaderViewModel.waitForState(NotifierState.ready);
    log.logInfo('Waiting for loading start animation to finish.');
    await loaderViewAnim.controllerStart.forward();

    // Log the readiness of the app, marking the transition from loading to main app view.
    log.logInfo('App is ready to start.');
    log.logInfo('Waiting for loading end animation to finish.');
    await loaderViewAnim.controllerEnd.forward();

    // Verify that the widget is still mounted to safely proceed with navigation.
    if (mounted) {
      log.logInfo('Navigating out: LoaderView -> LoginView');
      // Navigate to LoginView to transition from the loading screen to the main application.
      context.pushReplacement(const LoginView());
    }
  }

  @override
  void dispose() {
    // Dispose of the animation controllers to free resources when the widget is removed from the widget tree.
    loaderViewAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer2 to rebuild the UI when either LoaderViewModel or SettingsViewModel changes, ensuring a responsive interface.
    return Consumer2<LoaderViewModel, SettingsViewModel>(
      builder: (_, loaderViewModel, settingsViewModel, __) {
        // Check for error state in LoaderViewModel; we log the error and show an error message to provide clear user feedback.
        if (loaderViewModel.state == NotifierState.error) {
          log.logError(
            'LoaderViewModel has met an error.',
            Exception(loaderViewModel.error),
          );
          return Scaffold(body: Center(child: Text(loaderViewModel.error)));
        }

        // Determine which animation value to use based on the state of the end animation controller to achieve a smooth transition.
        double currentHeightFactor;
        if (loaderViewAnim.controllerEnd.isAnimating ||
            loaderViewAnim.controllerEnd.isCompleted) {
          currentHeightFactor = loaderViewAnim.animationEnd.value;
        } else {
          currentHeightFactor = loaderViewAnim.animationStart.value;
        }
        log.logData('Current animation height factor', currentHeightFactor);

        // Build the layered UI for the loader, providing visual feedback during the app's initialization phase.
        return Scaffold(
          body: Stack(
            children: [
              // Use a grayscale background image to create a subdued visual backdrop during loading.
              const ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black54,
                  BlendMode.hardLight,
                ),
                child: BackgroundCover(),
              ),
              // Position a color image that animates from the bottom, offering a dynamic reveal effect.
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: context.color.primary,
                          width: 1.sp,
                        ),
                      ),
                    ),
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: currentHeightFactor,
                        child: const BackgroundCover(),
                      ),
                    ),
                  ),
                ),
              ),
              // Overlay a semi-transparent layer to blend visual elements, which enhances the overall aesthetic during loading.
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.1)),
              ),
              // Provide a loading indicator to clearly communicate progress to the user.
              const LoadingPlaceholder(),
              // Display the app version label at the bottom if available to offer contextual app information.
              if (settingsViewModel.versionLabel != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BorderedText(
                    strokeColor: context.color.onPrimary,
                    strokeWidth: 1.spMax,
                    child: Text(
                      settingsViewModel.versionLabel!,
                      style: context.text.labelMedium!.copyWith(
                        color: context.color.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
