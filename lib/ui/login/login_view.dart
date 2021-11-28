import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/user_locations/user_locations.dart';
import 'package:baratito_mobile/ui/login/social_authentication_button.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class LoginView extends StatelessWidget {
  final SocialAuthenticationCubit socialAuthenticationCubit;
  final GoogleSignInService googleSignInService;

  const LoginView({
    required this.socialAuthenticationCubit,
    required this.googleSignInService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final screenPadding = context.screenPadding.vertical;
    return BlocListener<SocialAuthenticationCubit, SocialAuthenticationState>(
      bloc: socialAuthenticationCubit,
      listener: (context, state) {
        if (state is SocialAuthenticationSuccessful) {
          _navigateToUserLocationBarrier(context);
        } else if (state is SocialAuthenticationFailed) {
          showFailureDialog(context: context, failure: state.failure);
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
        _buildSignInText(context),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(16)),
          child: SocialAuthenticationButton.google(
            onPressed: _signInWithGoogle,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 16),
        //   child: SocialAuthenticationButton.facebook(onPressed: () {}),
        // ),
      ],
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return Row(
      children: [
        _buildLine(context),
        Text('login.sign_in'.tr(), style: context.theme.text.label),
        _buildLine(context),
      ],
    );
  }

  Widget _buildLine(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive(16, axis: Axis.horizontal),
        ),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: context.theme.colors.greyBackground,
          ),
        ),
      ),
    );
  }

  void _navigateToUserLocationBarrier(BuildContext context) {
    context.popAllAndPushReplacementView(
      const UserLocationSelectedBarrierView(),
      RouteTransitionType.fade,
    );
  }

  void _signInWithGoogle() async {
    final credentials = await googleSignInService.signIn();
    socialAuthenticationCubit.authenticate(credentials);
  }
}
