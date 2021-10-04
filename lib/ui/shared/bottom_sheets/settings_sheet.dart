import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/login/login.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/bottom_sheets/bottom_sheet_base.dart';

class SettingsSheet extends StatelessWidget {
  final AuthorizationCubit authorizationCubit;

  const SettingsSheet({
    required this.authorizationCubit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      builder: (_, scrollController) {
        return BottomSheetBase(
          title: 'settings.title'.tr(),
          child: _buildSettingsList(context),
        );
      },
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    final padding = (context.theme.dimensions as MobileDimensionTheme)
        .viewHorizontalPadding;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListItemBase(
            title: 'settings.enable_darkmode'.tr(),
            trailing: IgnorePointer(
              child: Switch.adaptive(
                value: context.isDarkmodeActive,
                onChanged: (_) {},
                activeColor: context.theme.colors.primary,
              ),
            ),
            onPressed: context.themeService.toggleTheme,
          ),
          Padding(
            padding: EdgeInsets.only(top: context.responsive(12)),
            child: ListItemBase(
              title: 'settings.sign_out'.tr(),
              onPressed: () => _signOut(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await authorizationCubit.signOut();
    context.pushReplacementView(
      LoginView(
        socialAuthenticationCubit: getDependency<SocialAuthenticationCubit>(),
        googleSignInService: getDependency<GoogleSignInService>(),
      ),
    );
  }
}
