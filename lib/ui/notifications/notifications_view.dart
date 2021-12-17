import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/shared.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(
      appBar: const MainAppBar(
        title: 'Notificaciones',
      ),
      child: _buildNotificationsList(context),
    );
  }

  Widget _buildNotificationsList(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final horizontalPadding = dimensionTheme.viewHorizontalPadding;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        16,
        horizontalPadding,
        0,
      ),
      child: Column(
        children: [
          IconListItem(
            title: 'Oferta de alimentos',
            subtitle1: 'A sólo \$228! Aceite de Girasol Cañuelas 1.5 Lt.',
            icon: BaratitoIcons.notification,
            iconColor: context.theme.colors.greyAccent,
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: IconListItem(
              title: 'Oferta de alimentos',
              subtitle1: 'A sólo \$99! Leche Entera Clásica Larga Vida Carton',
              icon: BaratitoIcons.notification,
              iconColor: context.theme.colors.greyAccent,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: IconListItem(
              title: 'Oferta de bebidas con alcohol',
              subtitle1:
                  'A sólo \$237! Vino Tinto Malbec Alaris Trapiche 750 Cc',
              icon: BaratitoIcons.notification,
              iconColor: context.theme.colors.greyAccent,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
