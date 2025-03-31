import 'package:flutter/material.dart';

extension ContextNavigatorExtensions on BuildContext {
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Future<T?> push<T extends Object?>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Route<T> newRoute,
      {TO? result}) {
    return Navigator.of(this).pushReplacement(newRoute, result: result);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, bool Function(Route<dynamic>) predicate) {
    return Navigator.of(this).pushAndRemoveUntil(newRoute, predicate);
  }
}

extension ContextThemeExtensions on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
