import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/home/feed/feed.dart';
import 'package:baratito_mobile/ui/home/library/library.dart';
import 'package:baratito_mobile/ui/home/navigation_bar.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

enum ActivePageState { feedActive, libraryActive }

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ActivePageState _activePage = ActivePageState.feedActive;

  @override
  Widget build(BuildContext context) {
    return View(
      fab: _buildFab(),
      fabLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildNavigationBar(),
      child: AnimatedCrossFade(
        crossFadeState: _activePage == ActivePageState.feedActive
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
        firstChild: const FeedPage(),
        secondChild: const LibraryPage(),
      ),
    );
  }

  Widget _buildFab() {
    return PrimaryButton(
      icon: BaratitoIcons.plus,
      label: 'lists.create'.tr(),
      onTap: () {},
    );
  }

  Widget _buildNavigationBar() {
    final activeIndex = _activePage == ActivePageState.feedActive ? 0 : 1;
    return NavigationBar(
      activeItemIndex: activeIndex,
      onItemSelected: _onNavigationBarItemSelected,
      items: const [
        NavigationBarItem(
          activeIcon: BaratitoIcons.homeBulk,
          inactiveIcon: BaratitoIcons.home,
        ),
        NavigationBarItem(
          activeIcon: BaratitoIcons.categoryBulk,
          inactiveIcon: BaratitoIcons.category,
        ),
      ],
    );
  }

  void _changePage(ActivePageState newActivePageState) {
    setState(() => _activePage = newActivePageState);
  }

  void _onNavigationBarItemSelected(int index) {
    final newActivePageState =
        index == 0 ? ActivePageState.feedActive : ActivePageState.libraryActive;
    _changePage(newActivePageState);
  }
}