import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shopping/shopping.dart';
import 'package:baratito_mobile/ui/home/feed/feed.dart';
import 'package:baratito_mobile/ui/home/library/library.dart';
import 'package:baratito_mobile/ui/home/navigation_bar.dart' as nav;
import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ActivePageState { feedActive, libraryActive }

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AuthenticatedUserProfileCubit _authenticatedUserProfileCubit;
  late ShoppingListsCubit _shoppingListsCubit;
  late ProductRecommendationsCubit _recommendationsCubit;

  ActivePageState _activePage = ActivePageState.feedActive;

  @override
  void initState() {
    _authenticatedUserProfileCubit =
        getDependency<AuthenticatedUserProfileCubit>();
    _shoppingListsCubit = getDependency<ShoppingListsCubit>();
    _recommendationsCubit = getDependency<ProductRecommendationsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListsCubit, ShoppingListsState>(
      bloc: _shoppingListsCubit,
      listener: (context, state) {
        if (state is ShoppingListsCreated) {
          _navigateToShoppingList(state.createdShoppingList);
        }
      },
      child: View(
        fab: _buildFab(),
        fabLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildNavigationBar(),
        child: AnimatedCrossFade(
          crossFadeState: _activePage == ActivePageState.feedActive
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 250),
          firstChild: _buildFeedPage(),
          secondChild: _buildLibraryPage(),
        ),
      ),
    );
  }

  void _navigateToShoppingList(ShoppingList shoppingList) {
    final shoppingListCubit = getDependency<ShoppingListCubit>();
    final shoppingListItemsCubit = getDependency<ShoppingListItemsCubit>();
    shoppingListCubit.load(shoppingList: shoppingList);
    shoppingListItemsCubit.load(shoppingList: shoppingList);
    context.pushView(ShoppingListDetailView(
      shoppingListCubit: shoppingListCubit,
      shoppingListItemsCubit: shoppingListItemsCubit,
    ));
  }

  Widget _buildFeedPage() {
    return FeedPage(
      authenticatedUserProfileCubit: _authenticatedUserProfileCubit,
      recommendationsCubit: _recommendationsCubit,
    );
  }

  Widget _buildLibraryPage() {
    return LibraryPage(
      shoppingListsCubit: _shoppingListsCubit,
    );
  }

  Widget _buildFab() {
    return PrimaryButton(
      icon: BaratitoIcons.plus,
      label: 'lists.create'.tr(),
      onTap: () => _shoppingListsCubit.create(),
    );
  }

  Widget _buildNavigationBar() {
    final activeIndex = _activePage == ActivePageState.feedActive ? 0 : 1;
    return nav.NavigationBar(
      activeItemIndex: activeIndex,
      onItemSelected: _onNavigationBarItemSelected,
      items: const [
        nav.NavigationBarItem(
          activeIcon: BaratitoIcons.homeBulk,
          inactiveIcon: BaratitoIcons.home,
        ),
        nav.NavigationBarItem(
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
