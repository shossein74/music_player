import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/functions.dart';

class PlayerController extends GetxController with GetTickerProviderStateMixin {
  PlayerController({this.onPlayNextSong});

  final Function()? onPlayNextSong;
  //final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  late AnimationController gradientAnimController;
  late AnimationController gradientFadeController;
  late Animation<Alignment> beginAlignment;
  late Animation<Alignment> endAlignment;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  RxList<SongModel> allSongs = <SongModel>[].obs;
  //RxList<SongModel> songs = <SongModel>[].obs;

  /*RxList<ArtistModel> allArtists = <ArtistModel>[].obs;
  RxList<ArtistModel> artists = <ArtistModel>[].obs;

  RxList<AlbumModel> allAlbums = <AlbumModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;

  RxList<String> allFolders = <String>[].obs;
  RxList<String> folders = <String>[].obs;*/

  RxBool isLoading = false.obs;
  RxBool isPlaying = false.obs;

  RxInt currentIndex = 0.obs;
  RxInt currentDuration = 0.obs;
  RxDouble currentImageIndex = 0.0.obs;

  var currentState = ProcessingState.idle.obs;

  Rx<AudioImageInfo> audioImageInfo = AudioImageInfo(null, [], []).obs;

  @override
  void onInit() {
    super.onInit();

    /*pageController.addListener(() {
      currentImageIndex.value = pageController.page ?? 0.0;
    });*/

    checkPermission();
    gradientAnimController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));

    gradientFadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    gradientAnimController.repeat();
    beginAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween:
            Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
    ]).animate(gradientAnimController);

    endAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
      TweenSequenceItem(
        tween:
            Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
            begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
    ]).animate(gradientAnimController);

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: gradientFadeController,
      curve: Curves.decelerate,
    ));

    if (audioImageInfo.value.imageBytes != null && audioPlayer.playing) {
      gradientAnimController.repeat();
    } else if (!audioPlayer.playing) {
      gradientAnimController.stop();
    }
  }

  @override
  void onClose() {}

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }

  SongModel getCurrentSong() {
    return allSongs[currentIndex.value];
  }

  /*/// User this function for retrieve song list on initializing
  Future<List<SongModel>> getSongList() async => audioQuery.querySongs(
        ignoreCase: true,
        uriType: UriType.EXTERNAL,
        orderType: OrderType.DESC_OR_GREATER,
        sortType: SongSortType.DATE_ADDED,
      );

  /// User this function for retrieve album list on initializing
  Future<List<AlbumModel>> getAlbumList() async => audioQuery.queryAlbums(
        ignoreCase: true,
        uriType: UriType.EXTERNAL,
        orderType: OrderType.DESC_OR_GREATER,
        sortType: AlbumSortType.ALBUM,
      );

  /// User this function for retrieve album list on initializing
  Future<List<ArtistModel>> getArtistList() async => audioQuery.queryArtists(
        ignoreCase: true,
        uriType: UriType.EXTERNAL,
        orderType: OrderType.DESC_OR_GREATER,
        sortType: ArtistSortType.NUM_OF_TRACKS,
      );

  /// User this function for retrieve folder list on initializing
  Future<List<String>> getFolderList() async => audioQuery.queryAllPath();

  /// Use this function for retrieve more songs (Paging)
  Future<void> fetchSongs() async {
    isLoading(true);
    songs.addAll(songs.length + 80 <= allSongs.length
        ? allSongs.sublist(songs.length, songs.length + 80)
        : allSongs.sublist(
            songs.length,
          ));
    isLoading(false);
  }*/

  /// This function with these two parameter try to playing song
  /// * @param [uri]: get uri from song model
  /// * @param index: index of song in loaded list with paging [songs]
  /// * IMPORTANT uri is nullable but if uri equal null so song definitely won't play
  void playSong(String? uri, int index) async {
    try {
      currentIndex.value = index;
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri ?? "")));

      isPlaying(true);
      audioPlayer.playerStateStream.listen((event) {
        currentState.value = event.processingState;
        if (event.processingState == ProcessingState.completed) {
          //isPlaying(false);
          //currentDuration.value = 0;
          playNextSong(index);
        }

        if (event.playing) {
          gradientAnimController.repeat();
        } else {
          gradientAnimController.stop();
        }
      });
      audioPlayer.positionStream.listen((event) {
        int durationMillis = event.inMilliseconds ?? 0;

        if (durationMillis >= 0 &&
            durationMillis <= (allSongs[index].duration ?? 0)) {
          currentDuration.value = durationMillis;
        }
      });

      audioPlayer.play();
      AudioImageInfo? imageInfo =
          await Utils.getSongImageInfo(OnAudioQuery(), allSongs[index]);
      audioImageInfo.value = imageInfo ?? AudioImageInfo(null, [], []);
      gradientFadeController.forward();
      gradientAnimController.repeat();
      //print(audioImageInfo.value);
    } catch (e) {
      print(e.toString());
    }
  }

  /// This function try to play next song in [allSongs]
  /// @param currentIndex: index of current song that selected or is playing
  /// if current index equals to last song index this func set fist song of list as current song
  void playNextSong(int currentIndex) {
    try {
      int lastSongIndex = allSongs.length - 1;

      if (currentIndex + 1 <= lastSongIndex) {
        playSong(allSongs[currentIndex + 1].uri, currentIndex + 1);
      } else {
        playSong(allSongs[0].uri, 0);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /// This function try to play previous song in [allSongs]
  /// @param currentIndex: index of current song that selected or is playing
  /// @param checkDuration: if this param value is true so func will check current duration position
  /// if current duration position bigger than 5 second, so current song will replay
  /// else will play previous song
  /// if current index equals to first song of list, this func will played current song from zero duration
  void playPreviousSong(int currentIndex, {bool checkDuration = true}) {
    try {
      if ((currentDuration.value > 5000 && checkDuration) ||
          currentIndex == 0) {
        audioPlayer.seek(Duration.zero);
      } else {
        playSong(allSongs[currentIndex - 1].uri, currentIndex - 1);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
