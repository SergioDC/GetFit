import 'package:flutter/material.dart';

class IconNovelNotInReadLater extends StatelessWidget {
  final double? size;
  const IconNovelNotInReadLater({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.collections_bookmark_outlined,
      color: Colors.lightBlue,
      size: size,
    );
  }
}
