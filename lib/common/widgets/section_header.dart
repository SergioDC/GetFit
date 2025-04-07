import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extensions.dart';

class SectionHeader extends StatelessWidget {
  final String label;

  const SectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: context.color.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
