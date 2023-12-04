import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabGetXController extends GetxController
    with GetTickerProviderStateMixin {
  final RxInt tabIndex = 3.obs;

  late PageController pageController;
  late PageController pageViewController;

  @override
  void onInit() {
    pageController = PageController(initialPage: tabIndex.value, viewportFraction: 0.26);
    pageViewController = PageController(initialPage: tabIndex.value);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    pageViewController.dispose();
    super.onClose();
  }

  void setTabIndex(int newTabIndex) {
    tabIndex.value = newTabIndex < 0 ? 0 : newTabIndex;
  }

}
