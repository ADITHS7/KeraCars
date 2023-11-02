import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/features/app_start/presentation/pages/onboarding_page.dart";
import "package:keracars_app/features/app_start/presentation/pages/splash_page.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";
import "package:keracars_app/features/auth/presentation/pages/login_page.dart";
import "package:keracars_app/features/auth/presentation/pages/register_page.dart";
import "package:keracars_app/features/auth/presentation/pages/root_auth_page.dart";
import "package:keracars_app/features/auth/presentation/pages/verify_otp_page.dart";
import "package:keracars_app/features/home_wrapper/presentation/pages/dummy_pages.dart";
import "package:keracars_app/features/home_wrapper/presentation/pages/greeting_screen.dart";
import "package:keracars_app/features/home_wrapper/presentation/pages/home_page.dart";

import "router_auth_notifier.dart";

class AppRoute {
  AppRoute() : _goRouter = AppRoute.init();

  final GoRouter _goRouter;

  GoRouter get goRouter => _goRouter;

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter init() {
    final RouterAuthNotifier routerAuthNotifier = RouterAuthNotifier();

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: $_RoutePath.splashPath,
      navigatorKey: rootNavigatorKey,
      redirect: routerAuthNotifier.redirect,
      routes: [
        GoRoute(path: "/", redirect: (context, state) => $_RoutePath.authPath),
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
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state, navigationShell) => HomePage(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteName.home,
                  path: "/home",
                  pageBuilder: (context, state) => const NoTransitionPage(child: PageA()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/b",
                  pageBuilder: (context, state) => const NoTransitionPage(child: PageB()),
                  routes: [
                    GoRoute(
                      path: "sub-b",
                      name: "sub-b",
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) => const SubPageB(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/c",
                  pageBuilder: (context, state) => const NoTransitionPage(child: PageC()),
                ),
              ],
            ),
          ],
        ),
      ],
      refreshListenable: routerAuthNotifier,
    );
  }
}
