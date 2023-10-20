import 'package:flutter/material.dart';
import 'package:keracars_app/config/theme/app_theme.dart';
import 'package:keracars_app/features/app_start/presentation/pages/app_start_page.dart';

void startApp() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeraCars App',
      theme: myTheme,
      home: const AppStartPage(),
    );
  }
}
