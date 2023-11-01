import "package:flutter/widgets.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";

class RouterAuthNotifier extends ChangeNotifier {
  RouterAuthNotifier() : _authBloc = GetIt.I<AuthBloc>() {
    _authBloc.stream.listen((event) => notifyListeners());
  }

  final AuthBloc _authBloc;

  final authRoutePaths = [$_RoutePath.loginPath, $_RoutePath.otpPath, $_RoutePath.registerPath];
  final excludeRoutePaths = [$_RoutePath.splashPath, $_RoutePath.onboardingPath];

  String? redirect(BuildContext context, GoRouterState state) {
    final loggingIn = authRoutePaths.contains(state.matchedLocation);
    final inAuth = state.matchedLocation == $_RoutePath.authPath;

    if (_authBloc.state is AuthInitial ||
        (_authBloc.state is AuthAuthenticated && !(loggingIn || inAuth)) ||
        excludeRoutePaths.contains(state.matchedLocation)) {
      return null;
    }

    final isAuthenticated = _authBloc.state is AuthAuthenticated;

    // if the user is not logged in, they need to login
    // bundle the location the user is coming from into a query parameter
    if (!isAuthenticated) {
      return loggingIn
          ? null
          : state.namedLocation(
              RouteName.login,
              queryParameters: {"from": state.fullPath ?? ""},
            );
    }

    // if the user is logged in, send them where they were going before
    return state.uri.queryParameters["from"] ??
        state.namedLocation(
          loggingIn ? RouteName.greet : RouteName.home,
        );
  }
}
