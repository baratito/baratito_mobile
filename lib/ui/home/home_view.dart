import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/home/navigation_bar.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activePage = 0;

  void _changePage(int newPageIndex) {
    setState(() => activePage = newPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return View(
      fab: PrimaryButton(
        icon: BaratitoIcons.plus,
        label: 'lists.create'.tr(),
        onTap: () {},
      ),
      fabLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        activeItemIndex: activePage,
        onItemSelected: _changePage,
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
      ),
      child: Container(),
    );
  }
}
