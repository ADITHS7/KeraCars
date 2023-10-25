import 'package:go_router/go_router.dart';
import 'package:keracars_app/features/app_start/presentation/pages/app_start_page.dart';
import 'package:keracars_app/features/app_start/presentation/pages/onboarding_page.dart';
import 'package:keracars_app/features/auth/presentation/blocs/blocs.dart';
import 'package:keracars_app/features/auth/presentation/pages/login_page.dart';
import 'package:keracars_app/features/auth/presentation/pages/root_page.dart';
import 'package:keracars_app/features/auth/presentation/pages/verify_otp_page.dart';

import 'router_auth_notifier.dart';

class AppRoute {
  AppRoute() : _goRouter = AppRoute.init();

  final GoRouter _goRouter;

  GoRouter get goRouter => _goRouter;

  static GoRouter init() {
    final RouterAuthNotifier routerAuthNotifier = RouterAuthNotifier();

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/start',
      routes: [
        GoRoute(path: '/', redirect: (context, state) => '/auth'),
        GoRoute(
          name: 'start',
          path: '/start',
          builder: (context, state) => const AppStartPage(),
        ),
        GoRoute(
          name: 'onboarding',
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          name: 'root',
          path: '/root',
          builder: (context, state) => const RootPage(),
          redirect: routerAuthNotifier.redirect,
          routes: [
            GoRoute(
              name: 'login',
              path: 'login',
              builder: (context, state) => const LoginPage(),
              routes: [
                GoRoute(
                  name: 'otp',
                  path: 'otp',
                  builder: (context, state) => VerifyOTPPage(bloc: state.extra as LoginBloc),
                ),
              ],
            ),
            GoRoute(
              name: 'home',
              path: 'home',
              // builder: (context, state) => const Home(),
            ),
          ],
        ),
      ],
      refreshListenable: routerAuthNotifier,
    );
  }
}
