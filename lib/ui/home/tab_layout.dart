import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app_colors.dart';
import 'package:music_player/controller/tab_controller.dart';
import 'package:music_player/gen/fonts.gen.dart';

class MTabBar extends StatefulWidget {
  const MTabBar({
    super.key,
  });

  @override
  State<MTabBar> createState() => _MTabBarState();
}

class _MTabBarState extends State<MTabBar> with TickerProviderStateMixin {
  late TabGetXController getXTabController;

  @override
  void initState() {
    getXTabController = Get.find<TabGetXController>();
    
    super.initState();
  }

  @override
  void dispose() {
    getXTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Column(
        children: [
          /*TabBar(
            controller: getXTabController.tabController,
            labelStyle: theme.textTheme.bodySmall,
            unselectedLabelColor: theme.colorScheme.onSurface,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            physics: const ScrollPhysics(),
            labelColor: Colors.white,
            indicator: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffC22BB7),
                  Color(0xff922FF5),
                ],
              ),
            ),
            indicatorPadding: const EdgeInsets.only(top: 45),
            splashBorderRadius: BorderRadius.circular(12),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Transform.scale(
                scale: getXTabController.getTabIndex() == 0 ? 1.4 : 1.0,
                child: TabItem(
                  title: "Songs",
                  theme: theme,
                  isSelected: getXTabController.getTabIndex() == 0,
                ),
              ),
              Transform.scale(
                scale: getXTabController.getTabIndex() == 1 ? 1.4 : 1.0,
                child: TabItem(
                  title: "Artists",
                  theme: theme,
                  isSelected: getXTabController.getTabIndex() == 1,
                ),
              ),
              Transform.scale(
                scale: getXTabController.getTabIndex() == 2 ? 1.4 : 1.0,
                child: TabItem(
                  title: "Albums",
                  theme: theme,
                  isSelected: getXTabController.getTabIndex() == 2,
                ),
              ),
              Transform.scale(
                scale: getXTabController.getTabIndex() == 3 ? 1.4 : 1.0,
                child: TabItem(
                  title: "Folders",
                  theme: theme,
                  isSelected: getXTabController.getTabIndex() == 3,
                ),
              ),
            ],
          ),*/
          SizedBox(
            height: 68,
            child: PageView(
                controller: getXTabController.pageController,
                onPageChanged: (index) {
                  print("PageControllerIndex: $index}");
                  getXTabController.tabIndex.value = index;
                  getXTabController.pageViewController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
                },
                children: [
                  Transform.scale(
                    scale: getXTabController.tabIndex.value == 0 ? 1.4 : 1.0,
                    child: TabItem(
                      title: "Songs",
                      theme: theme,
                      isSelected: getXTabController.tabIndex.value == 0,
                      onPressed: () {
                        if (getXTabController.tabIndex.value != 0) {
                          getXTabController.pageViewController.animateToPage(
                              0, duration: const Duration(
                              milliseconds: 300), curve: Curves.decelerate);
                        }
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: getXTabController.tabIndex.value == 1 ? 1.4 : 1.0,
                    child: TabItem(
                      title: "Artists",
                      theme: theme,
                      isSelected: getXTabController.tabIndex.value == 1,
                      onPressed: () {
                        if (getXTabController.tabIndex.value != 1) {
                          getXTabController.pageViewController.animateToPage(
                              1, duration: const Duration(
                              milliseconds: 300), curve: Curves.decelerate);
                        }
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: getXTabController.tabIndex.value == 2 ? 1.4 : 1.0,
                    child: TabItem(
                      title: "Albums",
                      theme: theme,
                      isSelected: getXTabController.tabIndex.value == 2,
                      onPressed: () {
                        if (getXTabController.tabIndex.value != 2) {
                          getXTabController.pageViewController.animateToPage(
                              2, duration: const Duration(
                              milliseconds: 300), curve: Curves.decelerate);
                        }
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: getXTabController.tabIndex.value == 3 ? 1.4 : 1.0,
                    child: TabItem(
                      title: "Playlists",
                      theme: theme,
                      isSelected: getXTabController.tabIndex.value == 3,
                      onPressed: () {
                        if (getXTabController.tabIndex.value != 3) {
                          getXTabController.pageViewController.animateToPage(
                              3, duration: const Duration(
                              milliseconds: 300), curve: Curves.decelerate);
                        }
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: getXTabController.tabIndex.value == 4 ? 1.4 : 1.0,
                    child: TabItem(
                      title: "Liked songs",
                      theme: theme,
                      isSelected: getXTabController.tabIndex.value == 4,
                      onPressed: () {
                        if (getXTabController.tabIndex.value != 4) {
                          getXTabController.pageViewController.animateToPage(
                              4, duration: const Duration(
                              milliseconds: 300), curve: Curves.decelerate);
                        }
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: getXTabController.tabIndex.value == 5 ? 1.4 : 1.0,
                    child: TabItem(
                      title: "Folders",
                      theme: theme,
                      isSelected: getXTabController.tabIndex.value == 5,
                      onPressed: () {
                        if (getXTabController.tabIndex.value != 5) {
                          getXTabController.pageViewController.animateToPage(
                              5, duration: const Duration(
                              milliseconds: 300), curve: Curves.decelerate);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
    required this.theme,
    required this.isSelected,
    this.onPressed,
  });

  final String title;
  final ThemeData theme;
  final bool isSelected;
  final Function()? onPressed;

  final selectedTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: FontFamily.urbanistMedium,
    fontSize: 16,
    color: Colors.white,
  );

  final unSelectedTextStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.urbanistMedium,
    fontSize: 13,
    color: DarkThemeColors.grayLight,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: isSelected
                ? selectedTextStyle.apply(color: theme.colorScheme.onBackground)
                : unSelectedTextStyle,
          ),
        ),
      ),
    );
  }
}
