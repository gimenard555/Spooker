import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';

Image profileImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Assets.images.mainLogo.image();
  }
  return Image.network(imageUrl);
}

Object profileImageProvider(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Assets.images.mainLogo.image();
  }
  return NetworkImage(imageUrl);
}

Image networkImage(String? url, {BoxFit? fit}) {
  final placeholder = Assets.images.mainLogo.image(fit: fit);
  if (url == null || url.isEmpty) {
    return placeholder;
  }
  return Image.network(
    url,
    fit: fit,
    errorBuilder: (context, url, dynamic error) => placeholder,
  );
}