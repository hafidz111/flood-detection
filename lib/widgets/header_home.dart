import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flutter/material.dart';

import 'home_tab_item.dart';
import 'logout_button.dart';

class HeaderHome extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final int currentIndex;

  const HeaderHome({
    super.key,
    required this.tabController,
    required this.currentIndex,
  });

  @override
  Size get preferredSize => const Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color activeColor = colorScheme.secondary;
    final Color inactiveColor = colorScheme.primary;
    final Color unselectedLabelColor =
        FloodDetectionColors.textUnselected.color;

    return AppBar(
      backgroundColor: colorScheme.primary,
      title: Image.asset('assets/images/logo.png', height: 50),
      centerTitle: true,
      elevation: 0,
      actions: const [LogoutButton()],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: inactiveColor,
          child: TabBar(
            controller: tabController,
            indicatorWeight: 0,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            indicator: const BoxDecoration(color: Colors.transparent),
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: HomeTabItem(
                  title: "Dashboard",
                  isSelected: currentIndex == 0,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  unselectedLabelColor: unselectedLabelColor,
                ),
              ),
              Tab(
                child: HomeTabItem(
                  title: "History",
                  isSelected: currentIndex == 1,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  unselectedLabelColor: unselectedLabelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
