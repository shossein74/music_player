import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/controller/audio_query_controller.dart';
import 'package:music_player/gen/assets.gen.dart';
import 'package:music_player/gen/fonts.gen.dart';
import 'package:music_player/app_colors.dart';
import 'package:music_player/utils/common_widgets.dart';
import 'package:music_player/utils/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../controller/player_controller.dart';

class SongScreen extends StatefulWidget {
  /*final SongModel song;
  final int index;*/

  const SongScreen({
    super.key,
    /*required this.song, required this.index*/
  });

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen>
    with SingleTickerProviderStateMixin {
  var playerController = Get.find<PlayerController>();
  var audioController = Get.find<AudioQueryController>();

  late AnimationController _animationController;
  late PageController pageController;

  late bool isLandscape;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    pageController = PageController(
      initialPage: playerController.currentIndex.value,
      viewportFraction: 0.94,
    );
    pageController.addListener(() {
      playerController.currentImageIndex.value = pageController.page ?? 0;
    });
    print("Init State Index: ${playerController.currentIndex.value}");

    /*controller.audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.loading) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });*/

    super.initState();
  }

  void playNextSong(int index) {
    if (index + 1 < playerController.allSongs.length) {
      pageController.animateToPage(
        index + 1,
        duration: const Duration(
          milliseconds: 600,
        ),
        curve: Curves.decelerate,
      );
    }
    playerController.playNextSong(index);
  }

  void playPreviousSong(int index, {checkDuration = true}) {
    if (index > 0) {
      pageController.animateToPage(
        index - 1,
        duration: const Duration(
          milliseconds: 600,
        ),
        curve: Curves.decelerate,
      );
    }
    playerController.playPreviousSong(index, checkDuration: checkDuration);
  }

  @override
  void dispose() {
    //_animationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: const Color(0xff0F0817),
      body: Obx(() {
        final index = playerController.currentIndex.value;
        final SongModel song = playerController.allSongs[index];
        return GestureDetector(
          /*onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null) {
              if (details.primaryVelocity! > 0) {
                playPreviousSong(index, checkDuration: false);
              } else if (details.primaryVelocity! < 0) {
                playNextSong(index);
              }
            }
          },*/
          child: Stack(
            children: [
              Positioned.fill(
                child: Obx(
                  () {
                    var colors =
                        playerController.audioImageInfo.value.colorList;
                    if (colors == null || colors.isEmpty) {
                      colors = [
                        theme.colorScheme.background,
                        theme.colorScheme.onBackground.withOpacity(0.05),
                      ];
                    }

                    print(playerController
                        .audioImageInfo.value.paletteColors.length);

                    return AnimatedOpacity(
                      opacity: playerController.fadeAnimation.value,
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedBuilder(
                        animation: playerController.gradientAnimController,
                        builder: (context, child) =>
                            Utils.buildBackgroundGradient(
                          theme,
                          size,
                          colorList: colors,
                          beginAlign: playerController.beginAlignment.value,
                          endAlign: playerController.endAlignment.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
              /*Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0.5,
                    sigmaY: 0.5,
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),*/
              if (isLandscape) ...{
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildSongImage(size, theme)),
                          Expanded(
                            child: Column(
                              children: [
                                buildAppbar(),
                                buildSongTitle(song, theme),
                                buildSongSubtitle(song, theme),
                                //const Expanded(child: SizedBox()),
                                buildSongControlPanel(
                                    size, song, context, index),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              } else ...{
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 128),
                    dragStartBehavior: DragStartBehavior.down,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 0, 54),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildAppbar(),
                          buildSongImage(size, theme),
                          buildSongTitle(song, theme),
                          buildSongSubtitle(song, theme),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 48,
                  child: buildSongControlPanel(size, song, context, index),
                ),
              }
            ],
          ),
        );
      }),
    );
  }

  Widget buildSongControlPanel(
      Size size, SongModel song, BuildContext context, int index) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 24.0,
            left: 24.0,
            top: 24,
          ),
          child: SizedBox(
            width: size.width,
            child: Obx(() {
              double sliderValue =
                  playerController.currentDuration.value.toDouble();
              double maxDuration = song.duration?.toDouble() ?? 0;
              if (sliderValue > maxDuration) {
                sliderValue = maxDuration;
              }
              if (sliderValue < 0) {
                sliderValue = 0;
              }
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackShape: CustomTrackShapeSlider(),
                  trackHeight: 1.6,
                  thumbShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  value: sliderValue,
                  min: 0,
                  max: maxDuration,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  thumbColor: DefaultThemeColors.grayLight,
                  activeColor: theme.brightness == Brightness.dark
                      ? Colors.white
                      : DarkThemeColors.background,
                  inactiveColor: DefaultThemeColors.grayLight,
                  onChanged: (value) {
                    sliderValue = value;
                    playerController.audioPlayer
                        .seek(Duration(milliseconds: value.toInt()));
                  },
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: Row(
            children: [
              Obx(
                () => Text(
                  Utils.getTime(playerController.currentDuration.value),
                  style: const TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 12,
                    color: DefaultThemeColors.grayLight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(
                Utils.getTime(song.duration ?? 0),
                style: const TextStyle(
                  fontFamily: FontFamily.urbanist,
                  fontSize: 12,
                  color: DefaultThemeColors.grayLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          bool isDarkMode = theme.brightness == Brightness.dark;
          Color? foregroundColor;
          Color? backgroundColor;
          if (playerController.audioImageInfo.value.imageBytes != null) {
            AudioImageInfo imageInfo = playerController.audioImageInfo.value;

            if (imageInfo.paletteColors.isNotEmpty) {
              PaletteColor paletteColor = imageInfo.paletteColors[0];
              foregroundColor = paletteColor.bodyTextColor;
              backgroundColor = paletteColor.color;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgIcon(
                    assetName: Assets.icons.shuffle,
                    iconSize: 18,
                    iconColor: theme.brightness == Brightness.dark
                        ? Colors.white
                        : foregroundColor ?? DarkThemeColors.background,
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          assetName: Assets.icons.skipBack,
                          iconColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : foregroundColor ?? DarkThemeColors.background,
                          onPressed: () {
                            playPreviousSong(index);
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            if (!playerController.audioPlayer.playing &&
                                playerController.audioPlayer.audioSource !=
                                    null) {
                              playerController.audioPlayer.play();
                              playerController.isPlaying(true);
                            } else if (playerController.currentState.value ==
                                ProcessingState.completed) {
                              playerController.playSong(
                                song.uri,
                                index,
                              );
                            } else if (playerController.audioPlayer.playing) {
                              playerController.isPlaying(false);
                              playerController.audioPlayer.pause();
                            } else {
                              playerController.playSong(song.uri, index);
                              playerController.isPlaying(true);
                            }
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: SvgIcon(
                            assetName: playerController.isPlaying.value
                                ? Assets.icons.pause
                                : Assets.icons.play,
                            iconColor: theme.brightness == Brightness.dark
                                ? DarkThemeColors.primaryTextColor
                                : backgroundColor ?? Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SvgIcon(
                          assetName: Assets.icons.skipForward,
                          iconColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : foregroundColor ?? DarkThemeColors.background,
                          onPressed: () {
                            playNextSong(index);
                          },
                        ),
                      ],
                    ),
                  ),
                  SvgIcon(
                    assetName: Assets.icons.repeat,
                    iconSize: 18,
                    iconColor: theme.brightness == Brightness.dark
                        ? Colors.white
                        : foregroundColor ?? DarkThemeColors.background,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget buildAppbar() {
    return Padding(
      padding: EdgeInsets.only(
        right: 16.0,
        left: 16.0,
        top: isLandscape ? 16.0 : 28.0,
      ),
      child: Row(
        children: [
          SvgIcon(
            assetName: Assets.icons.chevronLeft,
            onPressed: () {
              Get.back();
            },
          ),
          const Expanded(child: SizedBox()),
          SvgIcon(
            assetName: Assets.icons.moreHorizontal,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget buildSongSubtitle(SongModel song, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          song.artist ?? "",
          style: theme.textTheme.headlineLarge!.copyWith(
            fontFamily: FontFamily.urbanistMedium,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: DefaultThemeColors.grayLight,
          ),
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }

  Widget buildSongTitle(SongModel song, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              song.displayNameWOExt,
              style: theme.textTheme.headlineLarge!.copyWith(
                fontFamily: FontFamily.urbanistBold,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onBackground,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ),
          SvgIcon(
            assetName: Assets.icons.heart,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget buildSongImage(Size size, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(top: (isLandscape ? 16 : 28)),
      child: Center(
        child: SizedBox(
          width: size.width,
          height: size.width - 48,
          child: PageView.builder(
              controller: pageController,
              itemCount: playerController.allSongs.length,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                if (value > playerController.currentIndex.value) {
                  playNextSong(playerController.currentIndex.value);
                } else if (value < playerController.currentIndex.value) {
                  playPreviousSong(playerController.currentIndex.value,
                      checkDuration: false);
                }
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                  ),
                  child: QueryArtworkWidget(
                    controller: audioController.audioQuery,
                    size: (size.width).toInt(),
                    id: playerController.allSongs[position].id,
                    artworkFit: BoxFit.fill,
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(16.0),
                    artworkQuality: FilterQuality.high,
                    //artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                    quality: 100,
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: SvgIcon(
                          assetName: Assets.icons.song,
                          iconSize: 68,
                          iconColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : DarkThemeColors.background,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
