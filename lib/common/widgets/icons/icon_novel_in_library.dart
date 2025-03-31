import 'package:flutter/material.dart';

import '../../config/configuration.dart';

class IconNovelInLibrary extends StatelessWidget {
  final double? size;
  const IconNovelInLibrary({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bookmark,
      color: Configuration.specialColor,
      size: size,
    );
  }
}
