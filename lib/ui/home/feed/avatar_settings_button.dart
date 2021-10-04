import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class AvatarSettingsButton extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback? onPressed;

  const AvatarSettingsButton({
    Key? key,
    required this.avatarUrl,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const oversize = 4.0;
    final size = context.theme.dimensions.avatar + oversize;
    return InkWell(
      onTap: onPressed,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          children: [
            CircleBorderAvatar(avatarUrl: avatarUrl),
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildSettingsIcon(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsIcon(BuildContext context) {
    final size = context.theme.dimensions.avatar / 2;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        shape: BoxShape.circle,
        boxShadow: [context.theme.shadows.large],
      ),
      child: Center(
        child: Icon(
          BaratitoIcons.settings,
          color: context.theme.colors.iconAction,
          size: size / 1.5,
        ),
      ),
    );
  }
}
