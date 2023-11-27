import 'package:get/get.dart';
import 'package:music_player/ui/home/home.dart';
import 'package:music_player/ui/song/song.dart';

class AppPages {
  AppPages._();

  static const initialRoute = "/home";

  static final routes = [
    GetPage(
      name: _Path.home,
      page: () => const HomeScreen(),
    ),
  ];
}

abstract class _Path {
  static const home = "/home";
  static const song = "/song";
}
