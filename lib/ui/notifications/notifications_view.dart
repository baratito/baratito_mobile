import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/shared.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(
      appBar: const MainAppBar(
        title: 'Notifications',
      ),
      child: _buildNotificationsList(context),
    );
  }

  Widget _buildNotificationsList(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final horizontalPadding = dimensionTheme.viewHorizontalPadding;

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 0),
          child: IconListItem(
            title: 'Comprá verduras con Baratito',
            subtitle1: 'Llevate 5 choclos y 2 tomates de regalo.',
            icon: BaratitoIcons.notification,
            iconColor: context.theme.colors.greyAccent,
            actionIcon: BaratitoIcons.arrowRight,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
