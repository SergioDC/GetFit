import 'package:flutter/material.dart';

import 'log.dart';
import 'log.view.dart';

class LogViewItem extends StatelessWidget {
  final Log log;

  const LogViewItem({
    super.key,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    final (Color color, IconData icon) style = LogView.getLogStyle(log.level);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Icon(style.$2, color: style.$1),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              log.toString(),
              style: TextStyle(color: style.$1),
            ),
          ),
        ],
      ),
    );
  }
}
