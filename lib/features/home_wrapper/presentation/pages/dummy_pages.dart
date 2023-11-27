import "package:coolicons/coolicons.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/features/app_start/cubit/app_start_cubit.dart";
import "package:keracars_app/features/auth/blocs/remote/auth/auth_bloc.dart";

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: FilledButton.tonal(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromWidth(100),
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  foregroundColor: theme.colorScheme.primary,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "New Delhi",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Icon(Icons.location_on_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Coolicons.search),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Coolicons.notification_outline),
          ),
        ],
        foregroundColor: theme.colorScheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("This is the home page"),
              const SizedBox(height: 8),
              FilledButton(
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
      ),
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page B")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => context.goNamed("sub-b"),
              child: const Text("Go to sub page B"),
            ),
          ],
        ),
      ),
    );
  }
}

class SubPageB extends StatelessWidget {
  const SubPageB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sub Page B")),
      body: const Center(
        child: Text("SubPageB"),
      ),
    );
  }
}

class PageC extends StatelessWidget {
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page C")),
      body: const Center(
        child: Text("PageC"),
      ),
    );
  }
}
