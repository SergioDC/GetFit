import 'package:flutter/material.dart';
import 'package:getfit/common/extensions/image_extensions.dart';
import 'package:uuid/v4.dart';

import '../config/configuration.dart';

Image getSecureImage({
  required String url,
  double? height,
  double? width,
  int? cacheHeight,
  int? cacheWidth,
}) {
  var noCoverImage = Image.asset(
    Configuration.noCoverImage,
    fit: BoxFit.cover,
  );

  if (url.isEmpty) {
    return noCoverImage;
  }

  return Image.network(
    url,
    fit: BoxFit.cover,
    width: width,
    height: height,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
    errorBuilder: (context, error, stackTrace) {
      return noCoverImage;
    },
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;
      return const Center(child: CircularProgressIndicator());
    },
  );
}

class ImageWithErrorControl extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final bool useHero;

  const ImageWithErrorControl({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    this.useHero = false,
  });

  @override
  Widget build(BuildContext context) {
    var image = getSecureImage(
      url: url,
      height: height,
      width: width,
      cacheHeight: height.pixelRatio(context),
      cacheWidth: width.pixelRatio(context),
    );
    if (useHero) {
      var heroTag = url.isNotEmpty ? url : const UuidV4().generate();
      return Hero(tag: heroTag, child: image);
    } else {
      return image;
    }
  }
}
