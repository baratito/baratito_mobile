// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:baratito_core/src/auth/presentation/authorization_cubit/authorization_cubit.dart'
    as _i11;
import 'package:baratito_core/src/profiles/presentation/authenticated_user_profile_cubit/authenticated_user_profile_cubit.dart'
    as _i4;
import 'package:baratito_core/src/social_auth/presentation/social_authentication_cubit/social_authentication_cubit.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import '../authentication/google_sign_in.dart' as _i13;
import '../ui/app.dart' as _i12;
import '../ui/home/feed/feed_page.dart' as _i3;
import '../ui/home/home_view.dart' as _i7;
import '../ui/home/library/library_page.dart' as _i6;
import '../ui/login/login_view.dart' as _i8;
import '../ui/splash/splash_view.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final googleSignInModule = _$GoogleSignInModule();
  gh.lazySingleton<_i3.FeedPage>(
      () => _i3.FeedPage.withoutKey(get<_i4.AuthenticatedUserProfileCubit>()));
  gh.factory<_i5.GoogleSignIn>(() => googleSignInModule.signIn);
  gh.lazySingleton<_i6.LibraryPage>(() => _i6.LibraryPage.withoutKey());
  gh.lazySingleton<_i7.HomeView>(() =>
      _i7.HomeView.withoutKey(get<_i3.FeedPage>(), get<_i6.LibraryPage>()));
  gh.lazySingleton<_i8.LoginView>(() => _i8.LoginView.withoutKey(
      get<_i9.SocialAuthenticationCubit>(),
      get<_i7.HomeView>(),
      get<_i5.GoogleSignIn>()));
  gh.lazySingleton<_i10.SplashView>(() => _i10.SplashView.withoutKey(
      get<_i11.AuthorizationCubit>(),
      get<_i8.LoginView>(),
      get<_i7.HomeView>()));
  gh.lazySingleton<_i12.App>(() => _i12.App.withoutKey(get<_i10.SplashView>()));
  return get;
}

class _$GoogleSignInModule extends _i13.GoogleSignInModule {}
