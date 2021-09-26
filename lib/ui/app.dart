import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/splash/splash.dart';

@lazySingleton
class App extends StatelessWidget {
  final SplashView _splashView;

  const App(this._splashView, {Key? key}) : super(key: key);

  @factoryMethod
  factory App.withoutKey(SplashView _splashView) {
    return App(_splashView);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [Locale('es')],
        fallbackLocale: const Locale('es'),
        path: 'assets/localizations',
        assetLoader: YamlAssetLoader(),
        child: Builder(builder: (context) {
          return _buildApp(context);
        }),
      ),
    );
  }

  Widget _buildApp(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: _buildTheme(context),
      home: _splashView,
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'packages/baratito_ui/Poppins',
      scaffoldBackgroundColor: context.theme.colors.background,
    );
  }
}
