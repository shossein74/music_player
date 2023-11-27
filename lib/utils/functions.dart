import 'dart:core';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';

class Utils {
  static String getTime(int millis) {
    Duration position = Duration(milliseconds: millis);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(position.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(position.inSeconds.remainder(60));
    String time;
    if (twoDigits(position.inHours) == "00") {
      time = "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      time = "${twoDigits(position.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return time;
  }

  static Future<List<Color>?> getSongImageColors(
    OnAudioQuery audioQuery,
    SongModel song,
  ) async {
    final imageBytes = await audioQuery.queryArtwork(
      song.id,
      ArtworkType.AUDIO,
    );
    if (imageBytes == null) {
      return null;
    }

    ui.Image image = await decodeImageFromList(imageBytes);
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImage(image);
    int l = paletteGenerator.colors.length;
    if (l <= 0) {
      return null;
    }

    List<Color> dominantColors = [];

    if (paletteGenerator.darkMutedColor != null) {
      dominantColors
          .add(paletteGenerator.darkMutedColor!.color.withOpacity(0.5));
      print("DartMute");
    }
    /*if (paletteGenerator.lightVibrantColor != null) {
      dominantColors.add(paletteGenerator.lightVibrantColor!.color);
    }*/
    if (paletteGenerator.lightVibrantColor != null) {
      dominantColors
          .add(paletteGenerator.lightVibrantColor!.color.withOpacity(0.5));
      print("LightVibrant");
    } else if (paletteGenerator.lightMutedColor != null) {
      dominantColors
          .add(paletteGenerator.lightMutedColor!.color.withOpacity(0.5));
    }
    if (paletteGenerator.darkVibrantColor != null) {
      dominantColors
          .add(paletteGenerator.darkVibrantColor!.color.withOpacity(0.5));
    }
    /* if (paletteGenerator.darkMutedColor != null) {
      dominantColors.add(paletteGenerator.darkMutedColor!.color);
    }*/
    /*if (paletteGenerator.dominantColor != null) {
      dominantColors.add(paletteGenerator.dominantColor!.color);
    }*/
    return dominantColors;
  }

  static Future<AudioImageInfo?> getSongImageInfo(
    OnAudioQuery audioQuery,
    SongModel song,
  ) async {
    final imageBytes = await audioQuery.queryArtwork(
      song.id,
      ArtworkType.AUDIO,
    );
    if (imageBytes == null) {
      return null;
    }

    ui.Image image = await decodeImageFromList(imageBytes);
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImage(image);
    int l = paletteGenerator.colors.length;
    if (l <= 0) {
      return null;
    }

    List<Color> dominantColors = [];

    if (paletteGenerator.darkMutedColor != null) {
      dominantColors
          .add(paletteGenerator.darkMutedColor!.color.withOpacity(0.5));
    }

    if (paletteGenerator.lightVibrantColor != null) {
      dominantColors
          .add(paletteGenerator.lightVibrantColor!.color.withOpacity(0.5));
    } else if (paletteGenerator.lightMutedColor != null) {
      dominantColors
          .add(paletteGenerator.lightMutedColor!.color.withOpacity(0.5));
    }

    if (paletteGenerator.darkVibrantColor != null) {
      dominantColors
          .add(paletteGenerator.darkVibrantColor!.color.withOpacity(0.5));
    }

    var result = AudioImageInfo(
        imageBytes, dominantColors, paletteGenerator.paletteColors);
    return result;
  }

  static Widget buildBackgroundGradient(
    ThemeData theme,
    Size size, {
    List<Color>? colorList,
    Alignment beginAlign = Alignment.topRight,
    Alignment endAlign = Alignment.bottomLeft,
    double radius = 4,
  }) {
    if (colorList != null) {
      return Stack(
        children: [
          /*Positioned.fill(
            child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: */ /*RadialGradient(
                    colors: colorList2 ?? [], //.sublist(0, 4),
                    center: endAlign,
                    tileMode: TileMode.clamp,*/ /*

                      //radius: radius,

                      LinearGradient(
                    colors: colorList2 ?? [],
                    tileMode: TileMode.clamp,
                    begin: beginAlign,
                    end: endAlign,
                    //stops: stops
                    //radius: 0.95,
                    //tileMode: TileMode.clamp,
                  ),
                )),
          ),*/
          Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: /*RadialGradient(
                  colors: colorList, //.sublist(0, 4),
                  center: beginAlign,
                  tileMode: TileMode.clamp,
                  radius: radius,*/

                    LinearGradient(
                  colors: colorList,
                  tileMode: TileMode.clamp,
                  begin: endAlign,
                  end: beginAlign,
                  //stops: stops
                  //radius: 0.95,
                  //tileMode: TileMode.clamp,
                ),
              )),
        ],
      );
    }

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(20),
        /*gradient: RadialGradient(
          colors: [
            const Color.fromARGB(255, 155, 121, 241).withOpacity(0.22),
            const Color.fromARGB(255, 155, 121, 241).withOpacity(0.08),
            const Color.fromARGB(255, 155, 121, 241).withOpacity(0.01),
          ],
          center: Alignment.center,
          radius: 0.95,
          focal: const Alignment(-0.10, 0.1),
          tileMode: TileMode.clamp,
        ),*/
      ),
    );
  }
}

class AudioImageInfo {
  final Uint8List? imageBytes;
  final List<Color>? colorList;
  final List<PaletteColor> paletteColors;

  AudioImageInfo(this.imageBytes, this.colorList, this.paletteColors);
}
