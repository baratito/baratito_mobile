import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum SocialAuthenticationType { google, facebook }

class SocialAuthenticationButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final SocialAuthenticationType _type;

  const SocialAuthenticationButton({
    Key? key,
    required this.onPressed,
  })  : _type = SocialAuthenticationType.google,
        super(key: key);

  factory SocialAuthenticationButton.google({
    Key? key,
    required VoidCallback onPressed,
  }) {
    return SocialAuthenticationButton(
      key: key,
      onPressed: onPressed,
    );
  }

  const SocialAuthenticationButton.facebook({
    Key? key,
    required this.onPressed,
  })  : _type = SocialAuthenticationType.facebook,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentColor = context.theme.text.primaryButton.color;
    switch (_type) {
      case SocialAuthenticationType.google:
        return SolidButtonBase.extended(
          key: key,
          label: 'login.google'.tr(),
          leading: const _ButtonIcon(icon: BaratitoIcons.googleLogo),
          foregroundColor: contentColor,
          backgroundColor: context.theme.colors.socialAuthGoogle,
          onTap: onPressed,
        );
      case SocialAuthenticationType.facebook:
        return SolidButtonBase.extended(
          key: key,
          label: 'login.facebook'.tr(),
          leading: const _ButtonIcon(icon: BaratitoIcons.facebookLogo),
          foregroundColor: contentColor,
          backgroundColor: context.theme.colors.socialAuthFacebook,
          onTap: onPressed,
        );
    }
  }
}

class _ButtonIcon extends StatelessWidget {
  final IconData icon;

  const _ButtonIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentTheme = context.theme.text.primaryButton;
    final iconSize = contentTheme.fontSize! * 1.5;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Icon(
        icon,
        color: contentTheme.color,
        size: iconSize,
      ),
    );
  }
}
