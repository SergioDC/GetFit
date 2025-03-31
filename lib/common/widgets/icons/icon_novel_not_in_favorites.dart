import 'package:flutter/material.dart';

class IconNovelNotInFavorites extends StatelessWidget {
  final double? size;
  const IconNovelNotInFavorites({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.lightBlue,
      size: size,
    );
  }
}
