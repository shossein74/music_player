/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/album.svg
  String get album => 'assets/icons/album.svg';

  /// File path: assets/icons/artist.svg
  String get artist => 'assets/icons/artist.svg';

  /// File path: assets/icons/chevron_left.svg
  String get chevronLeft => 'assets/icons/chevron_left.svg';

  /// File path: assets/icons/circle_gradient.svg
  String get circleGradient => 'assets/icons/circle_gradient.svg';

  /// File path: assets/icons/folder.svg
  String get folder => 'assets/icons/folder.svg';

  /// File path: assets/icons/heart.svg
  String get heart => 'assets/icons/heart.svg';

  /// File path: assets/icons/more_horizontal.svg
  String get moreHorizontal => 'assets/icons/more_horizontal.svg';

  /// File path: assets/icons/pause.svg
  String get pause => 'assets/icons/pause.svg';

  /// File path: assets/icons/play.svg
  String get play => 'assets/icons/play.svg';

  /// File path: assets/icons/repeat.svg
  String get repeat => 'assets/icons/repeat.svg';

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';

  /// File path: assets/icons/shuffle.svg
  String get shuffle => 'assets/icons/shuffle.svg';

  /// File path: assets/icons/skip_back.svg
  String get skipBack => 'assets/icons/skip_back.svg';

  /// File path: assets/icons/skip_forward.svg
  String get skipForward => 'assets/icons/skip_forward.svg';

  /// File path: assets/icons/song.svg
  String get song => 'assets/icons/song.svg';

  /// List of all assets
  List<String> get values => [
        album,
        artist,
        chevronLeft,
        circleGradient,
        folder,
        heart,
        moreHorizontal,
        pause,
        play,
        repeat,
        search,
        shuffle,
        skipBack,
        skipForward,
        song
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/circle_gradient.png
  AssetGenImage get circleGradientPng =>
      const AssetGenImage('assets/images/circle_gradient.png');

  /// File path: assets/images/circle_gradient.svg
  String get circleGradientSvg => 'assets/images/circle_gradient.svg';

  /// File path: assets/images/intro_background.png
  AssetGenImage get introBackground =>
      const AssetGenImage('assets/images/intro_background.png');

  /// File path: assets/images/playlist_header.png
  AssetGenImage get playlistHeader =>
      const AssetGenImage('assets/images/playlist_header.png');

  /// File path: assets/images/slider_image1.png
  AssetGenImage get sliderImage1 =>
      const AssetGenImage('assets/images/slider_image1.png');

  /// File path: assets/images/slider_image2.png
  AssetGenImage get sliderImage2 =>
      const AssetGenImage('assets/images/slider_image2.png');

  /// File path: assets/images/song_image1.png
  AssetGenImage get songImage1 =>
      const AssetGenImage('assets/images/song_image1.png');

  /// File path: assets/images/song_image2.png
  AssetGenImage get songImage2 =>
      const AssetGenImage('assets/images/song_image2.png');

  /// File path: assets/images/song_image3.png
  AssetGenImage get songImage3 =>
      const AssetGenImage('assets/images/song_image3.png');

  /// File path: assets/images/song_image4.png
  AssetGenImage get songImage4 =>
      const AssetGenImage('assets/images/song_image4.png');

  /// File path: assets/images/song_image5.png
  AssetGenImage get songImage5 =>
      const AssetGenImage('assets/images/song_image5.png');

  /// File path: assets/images/song_image6.png
  AssetGenImage get songImage6 =>
      const AssetGenImage('assets/images/song_image6.png');

  /// File path: assets/images/song_image7.png
  AssetGenImage get songImage7 =>
      const AssetGenImage('assets/images/song_image7.png');

  /// File path: assets/images/song_image8.png
  AssetGenImage get songImage8 =>
      const AssetGenImage('assets/images/song_image8.png');

  /// File path: assets/images/song_image9.png
  AssetGenImage get songImage9 =>
      const AssetGenImage('assets/images/song_image9.png');

  /// List of all assets
  List<dynamic> get values => [
        circleGradientPng,
        circleGradientSvg,
        introBackground,
        playlistHeader,
        sliderImage1,
        sliderImage2,
        songImage1,
        songImage2,
        songImage3,
        songImage4,
        songImage5,
        songImage6,
        songImage7,
        songImage8,
        songImage9
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
