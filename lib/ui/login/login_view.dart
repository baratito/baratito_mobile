import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/home.dart';
import 'package:baratito_mobile/ui/login/social_authentication_button.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final screenPadding = context.screenPadding.vertical;
    return View(
      child: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight - screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 8),
                child: _buildLogo(context),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.responsive(24),
                  0,
                  context.responsive(24),
                  context.responsive(24),
                ),
                child: _buildButtons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final screenWidth = context.screenSize.width;
    return Column(
      children: [
        BaratitoIsotype(size: screenWidth / 4),
        Padding(
          padding: const EdgeInsets.only(top: 28),
          child: BaratitoLogotype(size: screenWidth / 1.5),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        SocialAuthenticationButton.google(
          onPressed: () {
            context.pushReplacementView(
              const HomeView(),
              RouteTransitionType.fade,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SocialAuthenticationButton.facebook(onPressed: () {}),
        ),
      ],
    );
  }
}
