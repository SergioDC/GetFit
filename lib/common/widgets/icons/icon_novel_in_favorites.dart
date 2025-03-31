import 'package:flutter/material.dart';

import '../../config/configuration.dart';

class IconNovelInFavorites extends StatelessWidget {
  final double? size;

  const IconNovelInFavorites({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      color: Configuration.specialColor,
      size: size,
    );
  }
}
