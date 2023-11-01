import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:go_router/go_router.dart";

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: OverflowBox(
        maxWidth: 1800,
        maxHeight: 1800,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: theme.colorScheme.primary,
              ),
            )
                .animate(
                  autoPlay: true,
                  onComplete: (_) async {
                    await Future.delayed(const Duration(milliseconds: 800));
                    if (context.mounted) context.go(context.namedLocation("home"));
                  },
                )
                .scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 1800),
                  alignment: Alignment.center,
                  curve: Curves.easeInOut,
                )
                .fadeOut(
                  delay: const Duration(milliseconds: 1500),
                  duration: const Duration(milliseconds: 800),
                ),
            Text(
              "WELCOME\nTO\nKERA CARS",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
              ),
            )
                .animate(autoPlay: true)
                .fadeIn(
                  duration: const Duration(milliseconds: 800),
                )
                .fadeOut(
                  delay: const Duration(milliseconds: 1500),
                  duration: const Duration(milliseconds: 800),
                ),
          ],
        ),
      ),
    );
  }
}
