import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/ui/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/audio_query_controller.dart';
import '../../gen/assets.gen.dart';

class AlbumList extends StatelessWidget {
  AlbumList({
    super.key,
    //required this.playerController,
    //required this.scrollController,
  });

  final PlayerController playerController = Get.find<PlayerController>();
  final AudioQueryController audioController = Get.find<AudioQueryController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<List<AlbumModel>>(
      future: audioController.getAlbumList(),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final hasError = snapshot.hasError;
        final hasData = snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData;

        if (isLoading) {
          playerController.isLoading(true);
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (hasError) {
          playerController.isLoading(false);
          return Center(
            child: Text(
              "An error happened...",
              style: theme.textTheme.bodyMedium!.apply(color: Colors.white),
            ),
          );
        } else if (hasData) {
          List<AlbumModel> albumList = snapshot.data ?? [];

          return ListView.builder(
            controller: audioController.albumsScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: albumList.length,
            itemBuilder: (context, index) {
              return AnimatedListItem(
                key: ValueKey<AlbumModel>(albumList[index]),
                child: AlbumItem(
                  audioController: audioController,
                  albumModel: albumList[index],
                  onPressed: () {
                    Get.to(
                      () => const PlaylistScreen(),
                      transition: Transition.circularReveal,
                      curve: Curves.decelerate,
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          //playerController.isLoading(false);
          return Center(
            child: Text(
              "You don't have any your device",
              style: theme.textTheme.bodyMedium!.apply(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}

class AlbumItem extends StatelessWidget {
  const AlbumItem({
    super.key,
    required this.audioController,
    required this.albumModel,
    this.onPressed,
  });

  final AudioQueryController audioController;
  final AlbumModel albumModel;
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
                id: albumModel.id,
                type: ArtworkType.ALBUM,
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
                      Assets.icons.album,
                      width: 28,
                      height: 28,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                      albumModel.album,
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
                      "${albumModel.numOfSongs} Songs",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: theme.colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedListItem extends StatelessWidget {
  final Widget child;

  const AnimatedListItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeInOut,
      )),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeInOut,
        )),
        child: child,
      ),
    );
  }
}
