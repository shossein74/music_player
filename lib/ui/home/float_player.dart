import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/controller/audio_query_controller.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../gen/assets.gen.dart';
import '../../app_colors.dart';
import '../../utils/common_widgets.dart';
import '../../utils/functions.dart';
import '../song/song.dart';

class FloatingPlayer extends StatelessWidget {
  FloatingPlayer({
    super.key,
  });

  final PlayerController playerController = Get.find<PlayerController>();
  final AudioQueryController audioController = Get.find<AudioQueryController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      if (playerController.audioPlayer.audioSource != null) {
        final currentSong =
            playerController.allSongs[playerController.currentIndex.value];
        double sliderValue = playerController.currentDuration.value.toDouble();
        double maxDuration = currentSong.duration?.toDouble() ?? 0;
        if (sliderValue > maxDuration) {
          sliderValue = maxDuration;
        }
        if (sliderValue < 0) {
          sliderValue = 0;
        }

        return Container(
          height: 68,
          decoration: BoxDecoration(
            color: (theme.brightness == Brightness.dark
                ? DarkThemeColors.primaryColor
                : DarkThemeColors.background),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16.0),
              topLeft: Radius.circular(16.0),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: playerController.fadeAnimation.value,
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedBuilder(
                    animation: playerController.gradientAnimController,
                    builder: (context, child) => ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
                      ),
                      child: Utils.buildBackgroundGradient(
                        theme,
                        MediaQuery.of(context).size,
                        colorList:
                            playerController.audioImageInfo.value.colorList ??
                                [theme.colorScheme.primary],
                        beginAlign: playerController.beginAlignment.value,
                        endAlign: playerController.endAlignment.value,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const SongScreen(),
                              transition: Transition.downToUp,
                              curve: Curves.easeInBack,
                              duration: const Duration(
                                milliseconds: 400,
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: QueryArtworkWidget(
                              controller: audioController.audioQuery,
                              id: currentSong.id,
                              type: ArtworkType.AUDIO,
                              size: 200,
                              keepOldArtwork: true,
                              artworkBorder: BorderRadius.circular(16.0),
                              nullArtworkWidget: Center(
                                child: SvgPicture.asset(
                                  Assets.icons.song,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const SongScreen(),
                                transition: Transition.downToUp,
                                curve: Curves.easeInBack,
                                duration: const Duration(
                                  milliseconds: 400,
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    currentSong.displayNameWOExt,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: DarkThemeColors.primaryTextColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    currentSong.artist ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style:
                                        theme.textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: theme.colorScheme.onSurface,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SvgIcon(
                          assetName: Assets.icons.heart,
                          iconSize: 18,
                          onPressed: () {},
                        ),
                        const SizedBox(
                          width: 8,
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
                                currentSong.uri,
                                playerController.currentIndex.value,
                              );
                            } else if (playerController.audioPlayer.playing) {
                              playerController.isPlaying(false);
                              playerController.audioPlayer.pause();
                            } else {
                              playerController.playSong(currentSong.uri,
                                  playerController.currentIndex.value);
                              playerController.isPlaying(true);
                            }
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Center(
                            child: SvgIcon(
                              assetName: playerController.isPlaying.value
                                  ? Assets.icons.pause
                                  : Assets.icons.play,
                              iconSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 4,
                    margin: const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackShape: CustomTrackShapeSlider(),
                        trackHeight: 1.6,
                        thumbShape: SliderComponentShape.noOverlay,
                      ),
                      child: Slider(
                        value: sliderValue,
                        min: 0,
                        max: maxDuration,
                        activeColor: DefaultThemeColors.white,
                        allowedInteraction: SliderInteraction.tapAndSlide,
                        inactiveColor: DefaultThemeColors.grayLight,
                        onChanged: (value) {
                          sliderValue = value;
                          playerController.audioPlayer
                              .seek(Duration(milliseconds: value.toInt()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      playerController.isPlaying.value;
      return const SizedBox();
    });
  }
}
