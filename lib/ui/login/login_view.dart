import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/home.dart';
import 'package:baratito_mobile/ui/login/social_authentication_button.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

@singleton
class LoginView extends StatelessWidget {
  final SocialAuthenticationCubit _socialAuthenticationCubit;
  final HomeView _homeView;
  final GoogleSignIn _googleSignIn;

  const LoginView(
    this._socialAuthenticationCubit,
    this._homeView,
    this._googleSignIn, {
    Key? key,
  }) : super(key: key);

  @factoryMethod
  factory LoginView.withoutKey(
    SocialAuthenticationCubit _socialAuthenticationCubit,
    HomeView _homeView,
    GoogleSignIn _googleSignIn,
  ) {
    return LoginView(_socialAuthenticationCubit, _homeView, _googleSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final screenPadding = context.screenPadding.vertical;
    return BlocListener<SocialAuthenticationCubit, SocialAuthenticationState>(
      bloc: _socialAuthenticationCubit,
      listener: (context, state) {
        if (state is SocialAuthenticationSuccessful) {
          _navigateToHome(context);
        }
      },
      child: View(
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
          onPressed: _signInWithGoogle,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SocialAuthenticationButton.facebook(onPressed: () {}),
        ),
      ],
    );
  }

  void _navigateToHome(BuildContext context) {
    context.pushReplacementView(
      _homeView,
      RouteTransitionType.fade,
    );
  }

  void _signInWithGoogle() async {
    final auth = await _googleSignIn.signIn();

    final authUser = await auth?.authentication;
    final socialAuthenticationToken = authUser?.idToken ?? '';

    final credentials = SocialAuthenticationCredentials(
      token: socialAuthenticationToken,
      type: SocialAuthenticationType.google,
    );
    _socialAuthenticationCubit.authenticate(credentials);
  }
}
