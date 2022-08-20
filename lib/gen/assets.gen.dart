/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/confetti_splash.json
  String get confettiSplash => 'assets/animations/confetti_splash.json';

  /// File path: assets/animations/spooker_back.json
  String get spookerBack => 'assets/animations/spooker_back.json';
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/montserrat_bold.otf
  String get montserratBold => 'assets/fonts/montserrat_bold.otf';

  /// File path: assets/fonts/montserrat_medium.otf
  String get montserratMedium => 'assets/fonts/montserrat_medium.otf';

  /// File path: assets/fonts/montserrat_regular.otf
  String get montserratRegular => 'assets/fonts/montserrat_regular.otf';

  /// File path: assets/fonts/painterz.ttf
  String get painterz => 'assets/fonts/painterz.ttf';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/add.png
  AssetGenImage get add => const AssetGenImage('assets/images/add.png');

  /// File path: assets/images/alert.png
  AssetGenImage get alert => const AssetGenImage('assets/images/alert.png');

  /// File path: assets/images/artwork.png
  AssetGenImage get artwork => const AssetGenImage('assets/images/artwork.png');

  /// File path: assets/images/back_arrow.png
  AssetGenImage get backArrow =>
      const AssetGenImage('assets/images/back_arrow.png');

  /// File path: assets/images/back_button.png
  AssetGenImage get backButton =>
      const AssetGenImage('assets/images/back_button.png');

  /// File path: assets/images/camera.png
  AssetGenImage get camera => const AssetGenImage('assets/images/camera.png');

  /// File path: assets/images/configuration.png
  AssetGenImage get configuration =>
      const AssetGenImage('assets/images/configuration.png');

  /// File path: assets/images/custom_floating.png
  AssetGenImage get customFloating =>
      const AssetGenImage('assets/images/custom_floating.png');

  /// File path: assets/images/empty_image_icon.png
  AssetGenImage get emptyImageIcon =>
      const AssetGenImage('assets/images/empty_image_icon.png');

  /// File path: assets/images/empty_logo.png
  AssetGenImage get emptyLogo =>
      const AssetGenImage('assets/images/empty_logo.png');

  /// File path: assets/images/error_logo.png
  AssetGenImage get errorLogo =>
      const AssetGenImage('assets/images/error_logo.png');

  /// File path: assets/images/gallery.png
  AssetGenImage get gallery => const AssetGenImage('assets/images/gallery.png');

  /// File path: assets/images/google_icon.png
  AssetGenImage get googleIcon =>
      const AssetGenImage('assets/images/google_icon.png');

  /// File path: assets/images/main_logo.png
  AssetGenImage get mainLogo =>
      const AssetGenImage('assets/images/main_logo.png');

  /// File path: assets/images/mini_logo.png
  AssetGenImage get miniLogo =>
      const AssetGenImage('assets/images/mini_logo.png');

  /// File path: assets/images/notifications.png
  AssetGenImage get notifications =>
      const AssetGenImage('assets/images/notifications.png');

  /// File path: assets/images/paint.png
  AssetGenImage get paint => const AssetGenImage('assets/images/paint.png');

  /// File path: assets/images/reminder.png
  AssetGenImage get reminder =>
      const AssetGenImage('assets/images/reminder.png');

  /// File path: assets/images/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/images/settings.png');

  /// File path: assets/images/splash_logo.png
  AssetGenImage get splashLogo =>
      const AssetGenImage('assets/images/splash_logo.png');

  /// File path: assets/images/take-photo.png
  AssetGenImage get takePhoto =>
      const AssetGenImage('assets/images/take-photo.png');
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
