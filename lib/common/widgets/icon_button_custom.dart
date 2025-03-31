import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final EdgeInsets? padding;

  const IconButtonCustom({
    super.key,
    this.onTap,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: child,
      ),
    );
  }
}
