import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late TabGetXController tabGetXController;

  @override
  void initState() {
    tabGetXController = Get.find<TabGetXController>();

    tabGetXController.tabController.animation?.addListener(() {
      if (tabGetXController.getTabIndex() !=
          tabGetXController.tabController.animation!.value.round()) {
        tabGetXController.setTabIndex(
            tabGetXController.tabController.animation!.value.round());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    tabGetXController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Column(
        children: [
          TabBar(
            controller: tabGetXController.tabController,
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
              TabItem(
                title: "Songs",
                theme: theme,
                isSelected: tabGetXController.getTabIndex() == 0,
              ),
              TabItem(
                title: "Artists",
                theme: theme,
                isSelected: tabGetXController.getTabIndex() == 1,
              ),
              TabItem(
                title: "Albums",
                theme: theme,
                isSelected: tabGetXController.getTabIndex() == 2,
              ),
              TabItem(
                title: "Folders",
                theme: theme,
                isSelected: tabGetXController.getTabIndex() == 3,
              ),
            ],
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
    color: Colors.white,
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
                : unSelectedTextStyle.apply(
                    color: theme.colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
