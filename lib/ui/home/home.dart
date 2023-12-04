import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/audio_query_controller.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/controller/tab_controller.dart';
import 'package:music_player/gen/assets.gen.dart';
import 'package:music_player/gen/fonts.gen.dart';
import 'package:music_player/ui/album/album_list.dart';
import 'package:music_player/ui/artist/artist_list.dart';
import 'package:music_player/ui/folder/folder_list.dart';
import 'package:music_player/ui/home/tab_layout.dart';
import 'package:music_player/utils/common_widgets.dart';

import '../song/song_list.dart';
import 'float_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AudioQueryController _audioController;
  late TabGetXController _tabGetXController;
  late PlayerController _playerController;

  @override
  void initState() {
    _audioController = Get.put(AudioQueryController());
    _tabGetXController = Get.put(TabGetXController());
    _playerController = Get.put(PlayerController());
    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    _audioController.dispose();
    _tabGetXController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const appbarColor = Color(0xFF181818);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: appbarColor,
          systemNavigationBarColor: theme.colorScheme.background,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: appbarColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 24, left: 24, top: 48),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "H",
                                style: theme.textTheme.headlineLarge!.copyWith(
                                  color: theme.colorScheme.onBackground,
                                  fontFamily: FontFamily.urbanistBold,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                " music player",
                                style: theme.textTheme.headlineLarge!.copyWith(
                                  fontFamily: FontFamily.urbanistMedium,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onBackground,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              SvgIcon(
                                assetName: Assets.icons.search,
                                iconColor: theme.colorScheme.onBackground,
                                splashColor: theme.colorScheme.onBackground
                                    .withOpacity(0.2),
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              SvgIcon(
                                assetName: Assets.icons.moreHorizontal,
                                iconColor: theme.colorScheme.onBackground,
                                splashColor: theme.colorScheme.onBackground
                                    .withOpacity(0.2),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 16,
                          ),
                          child: MTabBar(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _tabGetXController.pageViewController,
                      onPageChanged: (index) {
                        _tabGetXController.pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                        _tabGetXController.setTabIndex(index);
                      },
                      physics: const BouncingScrollPhysics(),
                      children: [
                        buildSongView(),
                        buildArtistView(),
                        buildAlbumsView(),
                        buildArtistView(),
                        buildAlbumsView(),
                        buildFoldersView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FloatingPlayer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField(ThemeData theme) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 12, left: 24, right: 24),
      decoration: BoxDecoration(
        color: const Color(0xffa5a5a5).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            CupertinoIcons.search,
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              style: theme.textTheme.bodyLarge!.apply(
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search song, playlist, artist ...",
                hintStyle: theme.textTheme.bodyLarge!.apply(
                  color: theme.colorScheme.onSurface,
                  fontFamily: FontFamily.urbanist,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFoldersView() {
    return KeepPageAlive(
      child: FolderList(),
    );
  }

  Widget buildAlbumsView() {
    return KeepPageAlive(child: AlbumList());
  }

  Widget buildArtistView() {
    return KeepPageAlive(
      child: ArtistList(),
    );
  }

  Widget buildSongView() {
    return const KeepPageAlive(
      child: SongList(),
    );
  }
}
