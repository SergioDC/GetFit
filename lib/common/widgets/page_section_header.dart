import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getfit/common/extensions/context_extensions.dart';

import '../config/configuration.dart';

class PageSectionHeader extends StatelessWidget {
  const PageSectionHeader(
      {super.key,
      required this.label,
      this.trailingWidget,
      this.centerRow = false});

  final String label;
  final Widget? trailingWidget;
  final bool centerRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Configuration.listHeaderHeight,
      width: double.infinity,
      color: Theme.of(context)
          .colorScheme
          .surface
          .withValues(alpha: Configuration.uiVeryLowTransparency),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
        ),
        child: Row(
          mainAxisAlignment:
              centerRow ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SizedBox(width: 8.sp),
            // Category Title with Enhanced Styling
            Text(
              label,
              style: context.text.titleSmall,
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
