import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/audio_query_controller.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/controller/tab_controller.dart';
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
  final _audioController = Get.put(AudioQueryController());
  final _playerController = Get.put(PlayerController());
  final _tabGetXController = Get.put(TabGetXController());
  //final _scrollController = ScrollController();
  //late TabController _tabController;

  @override
  void initState() {
    //_tabController = TabController(length: 4, vsync: this);
    /*_scrollController.addListener(() {
      double percentageScrolled = _scrollController.position.pixels /
          _scrollController.position.maxScrollExtent;
      // Adjust this threshold as needed (0.7 means 70% of the list)
      if (percentageScrolled > 0.40 &&
          _playerController.songs.length < _playerController.allSongs.length) {
        */ /*if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
              !_scrollController.position.outOfRange) {
          */ /*

        // Start fetching more songs when 80% of the list is scrolled
        _audioController.fetchSongs();
      }
    });*/
    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    _audioController.dispose();
    _tabGetXController.dispose();
    //_scrollController.dispose();
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff0F0817),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(0),
                /*gradient: RadialGradient(
                  colors: [
                    */ /*const Color.fromARGB(255, 155, 121, 241).withOpacity(0.22),
                    const Color.fromARGB(255, 155, 121, 241).withOpacity(0.08),
                    const Color.fromARGB(255, 155, 121, 241).withOpacity(0.01),*/ /*
                    theme.colorScheme.background
                  ],
                  center: Alignment.center,
                  radius: 0.95,
                  focal: const Alignment(-0.10, 0.1),
                  tileMode: TileMode.clamp,
                ),*/
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.5,
                sigmaY: 0.5,
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24, top: 68),
                  child: Text(
                    "Welcome Back!",
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontFamily: FontFamily.urbanistBold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 24,
                    left: 24,
                    top: 8,
                  ),
                  child: Text(
                    "What do you feel like today?",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: FontFamily.urbanistMedium,
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  decoration: BoxDecoration(
                      color: const Color(0xffa5a5a5).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)),
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
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 16,
                  ),
                  child: MTabBar(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabGetXController.tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      buildSongView(),
                      buildArtistView(),
                      buildAlbumsView(),
                      buildFoldersView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FloatingPlayer(),
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
    return KeepPageAlive(
        child: AlbumList());
  }

  Widget buildArtistView() {
    return KeepPageAlive(
      child: ArtistList(),
    );
  }

  Widget buildSongView() {
    return KeepPageAlive(
      child: SongList(),
    );
  }
}
