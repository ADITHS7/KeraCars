import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:keracars_app/features/app_start/presentation/cubit/app_start_cubit.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HOME")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the home page"),
            FilledButton.tonal(
              onPressed: () => GetIt.I<AuthBloc>().add(RemoveAuthentication()),
              child: const Text("Logout"),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => GetIt.I<AppStartCubit>().goToPage(0),
              child: const Text("Reset onboarding"),
            ),
          ],
        ),
      ),
    );
  }
}
