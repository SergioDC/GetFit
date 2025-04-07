import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../config/configuration.dart';

class ColumnCard extends StatelessWidget {
  const ColumnCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer.withValues(
        alpha: Configuration.uiLowTransparency,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1)
                Divider(color: context.color.onSurfaceVariant),
            ],
          ],
        ),
      ),
    );
  }
}
