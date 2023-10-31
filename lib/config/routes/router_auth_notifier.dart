import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:keracars_app/features/auth/presentation/blocs/blocs.dart';

class RouterAuthNotifier extends ChangeNotifier {
  RouterAuthNotifier() : _authBloc = GetIt.I<AuthBloc>() {
    _authBloc.stream.listen((event) {
      notifyListeners();
    });
  }

  final AuthBloc _authBloc;

  String? redirect(BuildContext context, GoRouterState state) {
    if (_authBloc.state is AuthInitial) return null;

    final loginPaths = ['/root/login', '/root/login/otp', '/root/login/register'];

    // if the user is not logged in, they need to login
    final isAuthenticated = _authBloc.state is AuthAuthenticated;
    final loggingIn = loginPaths.contains(state.fullPath);

    // bundle the location the user is coming from into a query parameter
    final from = state.matchedLocation == '/root/home' ? '' : '?from=${state.fullPath}';
    if (!isAuthenticated) return loggingIn ? null : '/root/login$from';

    // if the user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    return state.uri.queryParameters['from'] ?? '/root/home';
  }
}
