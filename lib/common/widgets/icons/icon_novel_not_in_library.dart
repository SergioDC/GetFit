import 'package:flutter/material.dart';

class IconNovelNotInLibrary extends StatelessWidget {
  const IconNovelNotInLibrary({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bookmark_outline,
      color: Colors.lightBlue,
      size: size,
    );
  }
}
