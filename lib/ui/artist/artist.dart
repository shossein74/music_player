import 'package:flutter/material.dart';
import 'package:music_player/controller/player_controller.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen(
      {super.key,
      required this.playerController,
      required this.scrollController});

  final PlayerController playerController;
  final ScrollController scrollController;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  void initState() {
    /*_scrollController.addListener(() {
      double percentageScrolled = _scrollController.position.pixels /
          _scrollController.position.maxScrollExtent;
      if (percentageScrolled > 0.40 &&
          _playerController.songs.length < _playerController.allSongs.length) {
        */ /*if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {*/ /*
        _playerController.fetchSongs();
      }
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
