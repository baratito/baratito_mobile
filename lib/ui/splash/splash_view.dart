import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/login/login_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () => context.pushReplacementView(
        const LoginView(),
        RouteTransitionType.fade,
      ),
    );
    final screenWidth = context.screenSize.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaratitoIsotype(size: screenWidth / 2),
            ],
          )
        ],
      ),
    );
  }
}
