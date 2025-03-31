import 'package:flutter/material.dart';

import '../../common/config/configuration.dart';

class LoaderViewAnim {
  final TickerProvider tickerProvider;
  final Function() onSetState;

  late AnimationController controllerStart;
  late Animation<double> animationStart;
  late AnimationController controllerEnd;
  late Animation<double> animationEnd;
  LoaderViewAnim({
    required this.tickerProvider,
    required this.onSetState,
  }) {
    initializeAnimations();
  }

  void initializeAnimations() {
    _initializeStartAnimation();
    _initializeEndAnimation();
  }

  void dispose() {
    controllerStart.dispose();
    controllerEnd.dispose();
  }

  void _initializeStartAnimation() {
    // Initialize AnimationController
    controllerStart = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: Configuration.animLoadingFirstSectionDurationMs,
      ),
    );

    // Define start animation progress amount 0%
    animationStart = Tween<double>(
      begin: 0.0,
      end: Configuration.animLoadingStopThreshold,
    ).animate(
      CurvedAnimation(parent: controllerStart, curve: Curves.easeInOut),
    )..addListener(() {
        onSetState();
      });
  }

  // Initialize the second animation (0.7 to 1.0)
  void _initializeEndAnimation() {
    controllerEnd = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: Configuration.animLoadingSecondSectionDurationMs,
      ),
    );

    animationEnd = Tween<double>(
      begin: Configuration.animLoadingStopThreshold,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: controllerEnd, curve: Curves.easeInOut),
    )..addListener(() {
        onSetState();
      });
  }
}
