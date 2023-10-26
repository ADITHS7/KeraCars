import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:keracars_app/core/widgets/widgets.dart';
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
    final TextEditingController controller =
        TextEditingController.fromValue(TextEditingValue(text: (context.read<LoginBloc>().state as LoginInitial).requestOTP?.credential ?? ''));
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Sign in with your mobile number",
              style: theme.textTheme.titleMedium?.copyWith(color: theme.disabledColor),
            ),
            const SizedBox(height: 36),
            CustomTextFormField(
              autofocus: true,
              controller: controller,
              prefixText: '+91 ',
              isNumberInput: true,
            ),
            _checkboxTile(context),
            const SizedBox(height: 36),
            Center(child: _GetOTPButton(controller: controller, theme: theme)),
            const SizedBox(height: 36),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => context.go(context.namedLocation('signup')),
                          child: Text(
                            "Sign Up",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                    style: theme.textTheme.bodyMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Kera Cars "),
                      TextSpan(
                        text: "Privacy Policy ",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: "and "),
                      TextSpan(
                        text: "Terms and Conditions\n",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: "Kera Cars NBFC's "),
                      TextSpan(
                        text: "Terms of use ",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: "and\n"),
                      TextSpan(
                        text: "TU CIBIL terms of use",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                    style: theme.textTheme.bodyMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _checkboxTile(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      leading: SvgPicture.asset('assets/svg/whatsapp_icon.svg'),
      title: Text(
        'Get instant updates',
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('From Kera Cars on your whatsapp'),
      trailing: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return Checkbox.adaptive(
              value: state.requestOTP?.receiveUpdate ?? false,
              onChanged: (value) {
                context.read<LoginBloc>().add(CheckBoxChanged(value ?? false));
              },
              shape: const CircleBorder(),
            );
          }
          return const SizedBox();
        },
      ),
      contentPadding: const EdgeInsets.symmetric(),
    );
  }
}

class _GetOTPButton extends StatelessWidget {
  const _GetOTPButton({
    required this.controller,
    required this.theme,
  });

  final TextEditingController controller;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FilledButton(
          onPressed: state is! OTPRequestLoading
              ? () => context.read<LoginBloc>().add(RequestOTP(
                    '+91${controller.text}',
                    (state as LoginInitial).requestOTP?.receiveUpdate ?? false,
                  ))
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state is OTPRequestLoading ? "Processing..." : "Get OTP",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        );
      },
    );
  }
}
