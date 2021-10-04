import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/home.dart';
import 'package:baratito_mobile/ui/login/login.dart';

class SplashView extends StatelessWidget {
  final AuthorizationCubit authorizationCubit;

  const SplashView({
    required this.authorizationCubit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    authorizationCubit.checkAuthorizationStatus();

    final screenWidth = context.screenSize.width;
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      bloc: authorizationCubit,
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
      LoginView(
        socialAuthenticationCubit: getDependency<SocialAuthenticationCubit>(),
        googleSignInService: getDependency<GoogleSignInService>(),
      ),
      RouteTransitionType.fade,
    );
  }

  void _navigateToHome(BuildContext context) {
    context.pushReplacementView(
      const HomeView(),
      RouteTransitionType.fade,
    );
  }
}
