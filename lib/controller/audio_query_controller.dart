import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioQueryController extends GetxController {
  final audioQuery = OnAudioQuery();

  RxBool isLoading = false.obs;

  RxList<SongModel> allSongs = <SongModel>[].obs;
  RxList<SongModel> songs = <SongModel>[].obs;
  final songsScrollController = ScrollController();

  RxList<ArtistModel> allArtists = <ArtistModel>[].obs;
  RxList<ArtistModel> artists = <ArtistModel>[].obs;
  final artistsScrollController = ScrollController();

  RxList<AlbumModel> allAlbums = <AlbumModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  final albumsScrollController = ScrollController();

  RxList<String> allFolders = <String>[].obs;
  RxList<String> folders = <String>[].obs;
  final foldersScrollController = ScrollController();

  @override
  void onInit() {
    songsScrollController.addListener(() {
      double percentageScrolled = songsScrollController.position.pixels /
          songsScrollController.position.maxScrollExtent;

      if (percentageScrolled > 0.40 && songs.length < allSongs.length) {
        fetchSongs();
      }
    });

    artistsScrollController.addListener(() {
      double percentageScrolled = artistsScrollController.position.pixels /
          artistsScrollController.position.maxScrollExtent;

      if (percentageScrolled > 0.40 && artists.length < allArtists.length) {
        fetchArtists();
      }
    });

    albumsScrollController.addListener(() {
      double percentageScrolled = albumsScrollController.position.pixels /
          albumsScrollController.position.maxScrollExtent;

      if (percentageScrolled > 0.40 && albums.length < allAlbums.length) {
        fetchAlbums();
      }
    });

    foldersScrollController.addListener(() {
      double percentageScrolled = foldersScrollController.position.pixels /
          foldersScrollController.position.maxScrollExtent;

      if (percentageScrolled > 0.40 && folders.length < allAlbums.length) {
        fetchFolders();
      }
    });

    checkPermission();

    super.onInit();
  }

  @override
  void onClose() {
    songsScrollController.dispose();
    artistsScrollController.dispose();
    albumsScrollController.dispose();
    foldersScrollController.dispose();
  }

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }

  /// User this function for retrieve song list on initializing
  Future<List<SongModel>> getSongList() async {
    //isLoading.value = true;
    return await audioQuery.querySongs(
      ignoreCase: true,
      uriType: UriType.EXTERNAL,
      orderType: OrderType.DESC_OR_GREATER,
      sortType: SongSortType.DATE_ADDED,
    );
    //print(allSongs.length);
    //await fetchSongs();
    //isLoading = false.obs;
    return allSongs;
  }

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
    songs.addAll(songs.length + 80 <= allSongs.length
        ? allSongs.sublist(songs.length, songs.length + 80)
        : allSongs.sublist(
            songs.length,
          ));
  }

  /// Use this function for retrieve more albums (Paging)
  Future<void> fetchAlbums() async {
    albums.addAll(albums.length + 80 <= allAlbums.length
        ? allAlbums.sublist(albums.length, albums.length + 80)
        : allAlbums.sublist(
            albums.length,
          ));
  }

  /// Use this function for retrieve more artists (Paging)
  Future<void> fetchArtists() async {
    artists.addAll(artists.length + 80 <= allArtists.length
        ? allArtists.sublist(artists.length, artists.length + 80)
        : allArtists.sublist(
            artists.length,
          ));
  }

  /// Use this function for retrieve more folders (Paging)
  Future<void> fetchFolders() async {
    folders.addAll(folders.length + 80 <= allFolders.length
        ? allFolders.sublist(folders.length, folders.length + 80)
        : allFolders.sublist(
            folders.length,
          ));
  }
}
