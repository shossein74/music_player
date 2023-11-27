import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabGetXController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final RxInt _tabIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void setTabIndex(int newTabIndex) {
    _tabIndex.value = newTabIndex < 0 ? 0 : newTabIndex;
  }

  int getTabIndex() {
    return _tabIndex.value;
  }
}
