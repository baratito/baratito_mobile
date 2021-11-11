import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class MapLocationSearchItem extends StatelessWidget {
  final MapLocation mapLocation;
  final VoidCallback? onPressed;

  const MapLocationSearchItem({
    Key? key,
    required this.mapLocation,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconListItem(
      title: mapLocation.address,
      subtitle1: _buildSubtitle(),
      onPressed: onPressed,
      iconColor: context.theme.colors.greyAccent,
      icon: BaratitoIcons.location,
      actionIcon: BaratitoIcons.arrowRight,
    );
  }

  String? _buildSubtitle() {
    final country = mapLocation.country;
    final city = mapLocation.city;
    if (city.isEmpty || country.isEmpty) return null;
    return '${country.value}, ${city.value}';
  }
}
