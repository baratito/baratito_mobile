// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:baratito_core/src/auth/presentation/authorization_cubit/authorization_cubit.dart'
    as _i8;
import 'package:baratito_core/src/social_auth/presentation/social_authentication_cubit/social_authentication_cubit.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../authentication/google_sign_in.dart' as _i10;
import '../ui/app.dart' as _i9;
import '../ui/home/home_view.dart' as _i4;
import '../ui/login/login_view.dart' as _i5;
import '../ui/splash/splash_view.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final googleSignInModule = _$GoogleSignInModule();
  gh.factory<_i3.GoogleSignIn>(() => googleSignInModule.signIn);
  gh.singleton<_i4.HomeView>(_i4.HomeView.withoutKey());
  gh.singleton<_i5.LoginView>(_i5.LoginView.withoutKey(
      get<_i6.SocialAuthenticationCubit>(),
      get<_i4.HomeView>(),
      get<_i3.GoogleSignIn>()));
  gh.singleton<_i7.SplashView>(_i7.SplashView.withoutKey(
      get<_i8.AuthorizationCubit>(),
      get<_i5.LoginView>(),
      get<_i4.HomeView>()));
  gh.singleton<_i9.App>(_i9.App.withoutKey(get<_i7.SplashView>()));
  return get;
}

class _$GoogleSignInModule extends _i10.GoogleSignInModule {}
