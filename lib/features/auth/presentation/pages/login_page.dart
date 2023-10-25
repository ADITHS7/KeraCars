import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:keracars_app/features/auth/presentation/blocs/blocs.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (_) => GetIt.I<LoginBloc>(),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is OTPRequestSuccess) {
          context.go(
            context.namedLocation('otp'),
            extra: context.read<LoginBloc>(),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Login with your mobile number",
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
            ),
            TextFormField(controller: controller),
            const SizedBox(height: 36),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(RequestOTP(controller.text));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Get OTP",
                        style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
