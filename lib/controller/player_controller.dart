
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/functions.dart';

class PlayerController extends GetxController with GetTickerProviderStateMixin {
  PlayerController({this.onPlayNextSong});

  final Function()? onPlayNextSong;

  final audioPlayer = AudioPlayer();

  late AnimationController gradientAnimController;
  late AnimationController gradientFadeController;
  late Animation<Alignment> beginAlignment;
  late Animation<Alignment> endAlignment;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  RxList<SongModel> allSongs = <SongModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isPlaying = false.obs;

  RxInt currentIndex = 0.obs;
  RxInt currentDuration = 0.obs;
  RxDouble currentImageIndex = 0.0.obs;

  Rx<AudioImageInfo> audioImageInfo = AudioImageInfo(null, [], []).obs;

  var currentState = ProcessingState.idle.obs;

  @override
  void onInit() {
    super.onInit();

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
  void onClose() {
    audioPlayer.dispose();
    gradientAnimController.dispose();
    gradientFadeController.dispose();
  }

  Future<void> checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }

  SongModel getCurrentSong() {
    return allSongs[currentIndex.value];
  }

  /// This function with these two parameter try to playing song
  /// * @param [uri]: get uri from song model
  /// * @param index: index of song in loaded list with paging [songs]
  /// * IMPORTANT uri is nullable but if uri equal null so song definitely won't play
  Future<void> playSong(String? uri, int index) async {
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
        int durationMillis = event.inMilliseconds;

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
    } on PlayerException catch (e) {
      print("Error code: ${e.code}");
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print(e);
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
