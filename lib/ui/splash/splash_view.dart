import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/home/home.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/login/login.dart';

@lazySingleton
class SplashView extends StatelessWidget {
  final AuthorizationCubit _authorizationCubit;
  final LoginView _loginView;
  final HomeView _homeView;

  const SplashView(
    this._authorizationCubit,
    this._loginView,
    this._homeView, {
    Key? key,
  }) : super(key: key);

  @factoryMethod
  factory SplashView.withoutKey(
    AuthorizationCubit _authorizationCubit,
    LoginView _loginView,
    HomeView _homeView,
  ) {
    return SplashView(_authorizationCubit, _loginView, _homeView);
  }

  @override
  Widget build(BuildContext context) {
    _authorizationCubit.checkAuthorizationStatus();

    final screenWidth = context.screenSize.width;
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      bloc: _authorizationCubit,
      listener: (context, state) {
        if (state is AuthorizationSuccessful) {
          _navigateToHome(context);
        } else if (state is AuthorizationFailed) {
          _navigateToLogin(context);
        }
      },
      child: Scaffold(
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
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    context.pushReplacementView(
      _loginView,
      RouteTransitionType.fade,
    );
  }

  void _navigateToHome(BuildContext context) {
    context.pushReplacementView(
      _homeView,
      RouteTransitionType.fade,
    );
  }
}
