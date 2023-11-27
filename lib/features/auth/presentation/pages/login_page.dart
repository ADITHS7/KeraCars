import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/core/error/network_exception.dart";
import "package:keracars_app/core/widgets/widgets.dart";
import "package:keracars_app/features/auth/blocs/blocs.dart";
import "package:keracars_app/features/auth/presentation/widgets/widgets.dart";

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
        if (state is OTPRequestSuccess && !state.resending) {
          context.goNamed(
            RouteName.otp,
            queryParameters: {"otpId": state.otpId},
            extra: context.read<LoginBloc>(),
          );
        } else if (state is OTPRequestError && state.exception != null) {
          ErrorAlertDialog.show(context, contentText: (state.exception as NetworkException).message ?? "Error");
        }
      },
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final state = context.read<LoginBloc>().state;

    final TextEditingController controller = TextEditingController.fromValue(
      TextEditingValue(text: state is LoginInitial ? state.requestOTPModel.credential : ""),
    );

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
              prefixText: "+91 ",
              isNumberInput: true,
            ),
            _checkboxTile(context),
            const SizedBox(height: 36),
            Center(
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return CTAButton(
                    text: state is OTPRequestLoading ? "Processing..." : "Get OTP",
                    onPressed: state is! OTPRequestLoading
                        ? () {
                            context.read<LoginBloc>().add(
                                  RequestOTP(
                                    controller.text.isEmpty ? "" : "+91${controller.text}",
                                    state.requestOTPModel.receiveUpdate,
                                  ),
                                );
                          }
                        : null,
                  );
                },
              ),
            ),
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
                          onTap: () => context.goNamed(
                            RouteName.register,
                            extra: context.read<LoginBloc>(),
                          ),
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
                SizedBox(height: MediaQuery.of(context).size.height * .22),
                const Divider(),
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
      leading: SvgPicture.asset("assets/svg/whatsapp_icon.svg"),
      title: Text(
        "Get instant updates",
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text("From Kera Cars on your whatsapp"),
      trailing: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return Checkbox.adaptive(
              value: state.requestOTPModel.receiveUpdate,
              onChanged: (value) {
                context.read<LoginBloc>().add(CheckBoxChanged(value ?? false));
              },
              shape: const CircleBorder(),
            );
          }
          return const SizedBox();
        },
      ),
      onTap: () {
        context.read<LoginBloc>().add(
              CheckBoxChanged(
                !(context.read<LoginBloc>().state.requestOTPModel.receiveUpdate),
              ),
            );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      tileColor: theme.colorScheme.primary.withAlpha(40),
    );
  }
}
