import 'package:flutter/material.dart';

class IconNovelCannotAddReadLater extends StatelessWidget {
  final double? size;
  const IconNovelCannotAddReadLater({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.collections_bookmark_outlined,
      color: Colors.grey,
      size: size,
    );
  }
}
