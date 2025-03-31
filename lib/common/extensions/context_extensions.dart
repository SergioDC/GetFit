import 'package:flutter/material.dart';

extension ContextNavigatorExtensions on BuildContext {
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  MaterialPageRoute<T> makeRouteTo<T extends Object?>(Widget widget) {
    return MaterialPageRoute(builder: (BuildContext context) => widget);
  }

  Future<T?> push<T extends Object?>(Widget route) {
    return Navigator.of(this).push(makeRouteTo<T>(route));
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget newRoute, {
    TO? result,
  }) {
    return Navigator.of(
      this,
    ).pushReplacement(makeRouteTo<T>(newRoute), result: result);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget newRoute,
    bool Function(Route<dynamic>) predicate,
  ) {
    return Navigator.of(
      this,
    ).pushAndRemoveUntil(makeRouteTo<T>(newRoute), predicate);
  }
}

extension ContextThemeExtensions on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
