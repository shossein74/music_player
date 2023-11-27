import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.dark.obs;

  void switchTheme() {
    currentTheme.value = (currentTheme.value == ThemeMode.light)
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
