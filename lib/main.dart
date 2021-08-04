import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/splash/splash.dart';

void main() {
  runApp(ThemeProvider(child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(context),
      home: const SplashView(),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: context.theme.colors.background,
    );
  }
}
