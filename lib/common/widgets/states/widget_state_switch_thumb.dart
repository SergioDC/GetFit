import 'package:flutter/material.dart';
import 'package:getfit/common/extensions/context_extensions.dart';

WidgetStateProperty<Icon?> getThumbIcon(BuildContext context) {
  return WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return Icon(
        Icons.check,
        color: context.color.primary,
      );
    }
    return const Icon(Icons.close);
  });
}
