/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/confetti_splash.json
  String get confettiSplash => 'assets/animations/confetti_splash.json';

  /// File path: assets/animations/spooker_back.json
  String get spookerBack => 'assets/animations/spooker_back.json';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/back_button.png
  AssetGenImage get backButton =>
      const AssetGenImage('assets/images/back_button.png');

  /// File path: assets/images/configuration.png
  AssetGenImage get configuration =>
      const AssetGenImage('assets/images/configuration.png');

  /// File path: assets/images/google_icon.png
  AssetGenImage get googleIcon =>
      const AssetGenImage('assets/images/google_icon.png');

  /// File path: assets/images/main_logo.png
  AssetGenImage get mainLogo =>
      const AssetGenImage('assets/images/main_logo.png');

  /// File path: assets/images/notifications.png
  AssetGenImage get notifications =>
      const AssetGenImage('assets/images/notifications.png');

  /// File path: assets/images/paint.png
  AssetGenImage get paint => const AssetGenImage('assets/images/paint.png');

  /// File path: assets/images/splash_logo.png
  AssetGenImage get splashLogo =>
      const AssetGenImage('assets/images/splash_logo.png');
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/alert_icon.svg
  SvgGenImage get alertIcon => const SvgGenImage('assets/svgs/alert_icon.svg');

  /// File path: assets/svgs/back_button.svg
  SvgGenImage get backButton =>
      const SvgGenImage('assets/svgs/back_button.svg');

  /// File path: assets/svgs/error_icon.svg
  SvgGenImage get errorIcon => const SvgGenImage('assets/svgs/error_icon.svg');

  /// File path: assets/svgs/light_logo.svg
  SvgGenImage get lightLogo => const SvgGenImage('assets/svgs/light_logo.svg');

  /// File path: assets/svgs/login_background.svg
  SvgGenImage get loginBackground =>
      const SvgGenImage('assets/svgs/login_background.svg');

  /// File path: assets/svgs/main_background.svg
  SvgGenImage get mainBackground =>
      const SvgGenImage('assets/svgs/main_background.svg');

  /// File path: assets/svgs/paint.svg
  SvgGenImage get paint => const SvgGenImage('assets/svgs/paint.svg');

  /// File path: assets/svgs/splash_logo.svg
  SvgGenImage get splashLogo =>
      const SvgGenImage('assets/svgs/splash_logo.svg');
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
