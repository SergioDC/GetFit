// ignore_for_file: use_build_context_synchronously

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
import '../settings/settings.viewmodel.dart';
import 'loader.view.anim.dart';
import 'loader.viewmodel.dart';

class LoaderView extends StatefulWidget {
  const LoaderView({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => const LoaderView(),
    );
  }

  @override
  State<LoaderView> createState() => _LoaderState();
}

class _LoaderState extends State<LoaderView> with TickerProviderStateMixin {
  final log = GetIt.instance<LogService>();
  late LoaderViewAnim loaderViewAnim;

  @override
  void initState() {
    super.initState();

    loaderViewAnim = LoaderViewAnim(
      tickerProvider: this,
      onSetState: refreshAnimatedUI,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeApp();
    });
  }

  void refreshAnimatedUI() {
    setState(() {});
  }

  Future<void> initializeApp() async {
    loaderViewAnim.controllerStart.forward();

    // Wait until the log service is ready
    while (!log.isReady) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    var info = await PackageInfo.fromPlatform();
    var settingsViewModel = GetIt.instance<SettingsViewModel>();
    settingsViewModel.versionLabel =
        '${info.appName} ${info.version}+${info.buildNumber}';

    var loaderViewModel = GetIt.instance<LoaderViewModel>();
    log.logInfo('Initializing application data.');
    await loaderViewModel.initializeAppData(context);
    log.logInfo('Application data is ready. Redirecting to main route.');

    log.logInfo('Waiting for LoaderViewModel to finish loading.');
    await loaderViewModel.waitForState(NotifierState.ready);
    log.logInfo('Waiting for loading start animation to finish.');
    await loaderViewAnim.controllerStart.forward();

    log.logInfo('App is ready to start.');
    log.logInfo('Waiting for loading end animation to finish.');
    await loaderViewAnim.controllerEnd.forward();

    if (mounted) {
      // log.logInfo('Navigating out: LoaderView -> Bookcase');
      // context.pushReplacement(BookcaseView.route());
    }
  }

  @override
  void dispose() {
    loaderViewAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoaderViewModel, SettingsViewModel>(
        builder: (_, loaderViewModel, settingsViewModel, __) {
      if (loaderViewModel.state == NotifierState.error) {
        log.logError(
          'LoaderViewModel has met an error.',
          Exception(loaderViewModel.error),
        );
        return Scaffold(
          body: Center(child: Text(loaderViewModel.error)),
        );
      }

      // Determine which animation is active
      double currentHeightFactor;
      if (loaderViewAnim.controllerEnd.isAnimating ||
          loaderViewAnim.controllerEnd.isCompleted) {
        currentHeightFactor = loaderViewAnim.animationEnd.value;
      } else {
        currentHeightFactor = loaderViewAnim.animationStart.value;
      }

      return Scaffold(
        body: Stack(
          children: [
            // Grayscale Background Image
            const ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black54,
                BlendMode.hardLight,
              ),
              child: BackgroundCover(),
            ),
            // Color Image Filling from Bottom
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
            //Optional: Overlay a semi-transparent layer
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
            // Loading Indicator or Error Message
            const LoadingPlaceholder(),
            if (settingsViewModel.versionLabel != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: BorderedText(
                  strokeColor: context.color.onPrimary,
                  strokeWidth: 1.spMax,
                  child: Text(
                    settingsViewModel.versionLabel!,
                    style: context.text.labelMedium!
                        .copyWith(color: context.color.primary),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
