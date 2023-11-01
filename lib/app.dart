import "package:flutter/material.dart";
import "package:keracars_app/config/routes/app_route.dart";
import "package:keracars_app/config/theme/app_theme.dart";

void startApp() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final routerConfig = AppRoute().goRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "KeraCars App",
      theme: AppTheme.theme,
      routerConfig: routerConfig,
    );
  }
}
