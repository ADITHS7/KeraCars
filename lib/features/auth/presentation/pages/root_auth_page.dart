import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";

class RootAuthPage extends StatelessWidget {
  const RootAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<AuthBloc>()..add(CheckAuthentication()),
      child: const _RootPage(),
    );
  }
}

class _RootPage extends StatelessWidget {
  const _RootPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              state is AuthInitial ? const CircularProgressIndicator.adaptive() : const SizedBox(),
              state is AuthInitial ? const SizedBox(height: 20) : const SizedBox(),
              Text(
                "Loading...",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          );
        },
      ),
    );
  }
}
