import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/features/app_start/presentation/pages/onboarding_page.dart";
import "package:keracars_app/features/app_start/presentation/pages/splash_page.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";
import "package:keracars_app/features/auth/presentation/pages/login_page.dart";
import "package:keracars_app/features/auth/presentation/pages/register_page.dart";
import "package:keracars_app/features/auth/presentation/pages/root_auth_page.dart";
import "package:keracars_app/features/auth/presentation/pages/verify_otp_page.dart";
import "package:keracars_app/features/home_wrapper/presentation/pages/greeting_screen.dart";
import "package:keracars_app/features/home_wrapper/presentation/pages/home_page.dart";

import "router_auth_notifier.dart";

class AppRoute {
  AppRoute() : _goRouter = AppRoute.init();

  final GoRouter _goRouter;

  GoRouter get goRouter => _goRouter;

  static GoRouter init() {
    final RouterAuthNotifier routerAuthNotifier = RouterAuthNotifier();

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/splash",
      redirect: routerAuthNotifier.redirect,
      routes: [
        GoRoute(path: "/", redirect: (context, state) => "/auth"),
        GoRoute(
          name: RouteName.splash,
          path: $_RoutePath.splashPath,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          name: RouteName.onboarding,
          path: $_RoutePath.onboardingPath,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          name: RouteName.auth,
          path: $_RoutePath.authPath,
          builder: (context, state) => const RootAuthPage(),
          routes: [
            GoRoute(
              name: RouteName.login,
              path: $_RoutePath.loginPath,
              builder: (context, state) => const LoginPage(),
              routes: [
                GoRoute(
                  name: RouteName.otp,
                  path: $_RoutePath.otpPath,
                  builder: (context, state) => VerifyOTPPage(
                    otpId: state.uri.queryParameters["otpId"] as String,
                    loginBloc: state.extra as LoginBloc,
                  ),
                ),
                GoRoute(
                  name: RouteName.register,
                  path: $_RoutePath.registerPath,
                  builder: (context, state) => RegisterPage(bloc: state.extra as LoginBloc),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: RouteName.greet,
          path: "/greet",
          builder: (context, state) => const GreetingScreen(),
        ),
        GoRoute(
          name: RouteName.home,
          path: "/home",
          builder: (context, state) => const HomePage(),
        ),
      ],
      refreshListenable: routerAuthNotifier,
    );
  }
}
