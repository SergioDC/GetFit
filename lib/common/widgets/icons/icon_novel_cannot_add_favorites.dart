import 'package:flutter/material.dart';

class IconNovelCannotAddFavorites extends StatelessWidget {
  final double? size;
  const IconNovelCannotAddFavorites({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.grey,
      size: size,
    );
  }
}
