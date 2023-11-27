import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app_themes.dart';
import 'package:music_player/routing/app_pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "H-MusicPlayer",
      debugShowCheckedModeBanner: false,
      enableLog: true,
      themeMode: ThemeMode.dark,
      darkTheme: darkThemeData,
      theme: lightThemeData,
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
    );
  }
}
