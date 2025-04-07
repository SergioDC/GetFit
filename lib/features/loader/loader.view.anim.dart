import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../log/log.service.dart';
import '../../common/config/configuration.dart';

class LoaderViewAnim {
  // We store the ticker provider to drive animations, ensuring synchronization with widget lifecycle events.
  final TickerProvider tickerProvider;
  // We use the onSetState callback to signal UI updates during animation changes.
  final Function() onSetState;

  // Declare controllers and animations for the first phase to provide gradual loading feedback.
  late AnimationController controllerStart;
  late Animation<double> animationStart;
  // Declare controllers and animations for the second phase to smoothly complete the loading sequence.
  late AnimationController controllerEnd;
  late Animation<double> animationEnd;

  // Acquire the logging service via dependency injection to enable consistent logging for debugging.
  final log = GetIt.instance<LogService>();

  // The constructor receives necessary dependencies and immediately sets up animations to ensure a responsive UI.
  LoaderViewAnim({required this.tickerProvider, required this.onSetState}) {
    log.logData(
      'Initializing LoaderViewAnim with tickerProvider',
      tickerProvider,
    );
    initializeAnimations();
  }

  // We initialize both animation segments to structure the overall loading process.
  void initializeAnimations() {
    _initializeStartAnimation();
    _initializeEndAnimation();
  }

  // Dispose of animation controllers to free resources and prevent memory leaks when the animations are no longer needed.
  void dispose() {
    controllerStart.dispose();
    controllerEnd.dispose();
  }

  // Initialize the start animation to represent the initial progress of the loading process.
  void _initializeStartAnimation() {
    // Create an AnimationController for the first loading phase to provide early visual feedback.
    controllerStart = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: Configuration.animLoadingFirstSectionDurationMs,
      ),
    );
    log.logData(
      'Initialized controllerStart with duration',
      Configuration.animLoadingFirstSectionDurationMs,
    );

    // Set up an animation that transitions from 0% to the defined stop threshold,
    // ensuring that the UI reflects a gradual loading state.
    animationStart = Tween<double>(
      begin: 0.0,
      end: Configuration.animLoadingStopThreshold,
    ).animate(
      CurvedAnimation(parent: controllerStart, curve: Curves.easeInOut),
    )..addListener(() {
      onSetState();
    });
    log.logData(
      'Set up animationStart from 0.0 to animLoadingStopThreshold',
      Configuration.animLoadingStopThreshold,
    );
  }

  // Initialize the end animation to transition smoothly from the intermediate state to full completion.
  void _initializeEndAnimation() {
    // Create an AnimationController for the final phase to provide a smooth transition to the complete state.
    controllerEnd = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: Configuration.animLoadingSecondSectionDurationMs,
      ),
    );
    log.logData(
      'Initialized controllerEnd with duration',
      Configuration.animLoadingSecondSectionDurationMs,
    );

    // Define an animation that moves from the stop threshold to 100%,
    // which ensures the loading process ends in a visually appealing manner.
    animationEnd = Tween<double>(
        begin: Configuration.animLoadingStopThreshold,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controllerEnd, curve: Curves.easeInOut))
      ..addListener(() {
        onSetState();
      });
    log.logData(
      'Set up animationEnd from animLoadingStopThreshold to 1.0',
      1.0,
    );
  }
}
