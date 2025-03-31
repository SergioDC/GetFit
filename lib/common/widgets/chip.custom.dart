import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getfit/common/extensions/context_extensions.dart';

class ChipCustom extends StatelessWidget {
  const ChipCustom({
    super.key,
    required this.label,
    this.size,
    this.backgroundColor,
    this.color,
  });

  final String label;
  final double? size;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var backColor = backgroundColor ?? context.color.surface;
    var frontColor = color ?? context.color.primary;

    return SizedBox(
      height: size ?? 20,
      child: Container(
        decoration: BoxDecoration(
          color: backColor,
          border: Border.all(
            color: frontColor,
            width: 1.spMax,
          ), // Border style
          borderRadius:
              BorderRadius.circular(16.spMax), // Optional for rounded edges
        ),
        padding:
            REdgeInsets.symmetric(horizontal: 2), // Padding for inner spacing
        child: FittedBox(
          child: Text(
            label,
            textAlign: TextAlign.center, // Center the text horizontally
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: frontColor),
          ),
        ),
      ),
    );
  }
}
