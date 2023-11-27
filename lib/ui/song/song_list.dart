import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/audio_query_controller.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/ui/song/song.dart';
import 'package:music_player/utils/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../gen/assets.gen.dart';

class SongList extends StatelessWidget {
  SongList({
    super.key,
    //required this.playerController,
    //required this.audioController,
    //required this.scrollController,
  });

  final PlayerController playerController = Get.find<PlayerController>();
  final AudioQueryController audioController = Get.find<AudioQueryController>();
  //final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: audioController.getSongList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print('done');
            audioController.allSongs.value = snapshot.data!;
            playerController.allSongs.value = snapshot.data!;
            return Center(
              child: Obx(() {
                //playerController.allSongs.value = audioController.allSongs;
                return ListView.builder(
                  //controller: audioController.songsScrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemExtent: 78,
                  itemCount: audioController.allSongs.length,
                  padding: const EdgeInsets.only(top: 8, bottom: 98),
                  itemBuilder: (context, index) {
                    return SongItem(
                      audioController: audioController,
                      songModel: audioController.allSongs[index],
                      onPressed: () {
                        playerController.playSong(
                            playerController.allSongs[index].uri, index);
                        /*Get.to(
                            () => const SongScreen(),
                            transition: Transition.downToUp,
                            curve: Curves.easeInBack,
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                          );*/
                      },
                    );
                  },
                );
              }),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error ",
                style: theme.textTheme.bodyMedium!.apply(color: Colors.white),
              ),
            );
          }
          return Center(
            child: Text(
              "You don't have any song in your device",
              style: theme.textTheme.bodyMedium!.apply(color: Colors.white),
            ),
          );
        }
        print("loading...");
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
    required this.audioController,
    required this.songModel,
    this.onPressed,
  });

  final AudioQueryController audioController;
  final SongModel songModel;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: QueryArtworkWidget(
                controller: audioController.audioQuery,
                id: songModel.id,
                type: ArtworkType.AUDIO,
                keepOldArtwork: true,
                nullArtworkWidget: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.icons.song,
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
                artworkClipBehavior: Clip.antiAlias,
                artworkWidth: 54,
                artworkHeight: 54,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      songModel.displayNameWOExt,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      songModel.artist ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              Utils.getTime(songModel.duration ?? 0),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w300,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
