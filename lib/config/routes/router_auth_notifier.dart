import "package:flutter/widgets.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";

class RouterAuthNotifier extends ChangeNotifier {
  RouterAuthNotifier() : _authBloc = GetIt.I<AuthBloc>() {
    _authBloc.stream.listen((event) => notifyListeners());
  }

  final AuthBloc _authBloc;

  final authPath = "/auth";
  final loginPaths = ["/auth/login", "/auth/login/otp", "/auth/login/register"];
  final excludePaths = ["/start", "/onboarding"];

  String? redirect(BuildContext context, GoRouterState state) {
    final loggingIn = loginPaths.contains(state.fullPath) || state.fullPath == authPath;

    if (_authBloc.state is AuthInitial || (_authBloc.state is AuthAuthenticated && !loggingIn) || excludePaths.contains(state.fullPath)) return null;

    // if the user is not logged in, they need to login
    final isAuthenticated = _authBloc.state is AuthAuthenticated;

    // bundle the location the user is coming from into a query parameter
    final from = "?from=${state.fullPath}";
    if (!isAuthenticated) return loggingIn ? null : "/auth/login$from";

    // if the user is logged in, send them where they were going before
    return state.uri.queryParameters["from"] ?? (loggingIn ? "/greet" : "/home");
  }
}
