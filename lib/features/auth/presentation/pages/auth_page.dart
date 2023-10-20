import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => const AuthPage(),
      );

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is the auth page"),
    );
  }
}
