import 'package:flutter/material.dart';

import '../../config/configuration.dart';

class IconNovelInReadLater extends StatelessWidget {
  final double? size;

  const IconNovelInReadLater({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.collections_bookmark,
      color: Configuration.specialColor,
      size: size,
    );
  }
}
