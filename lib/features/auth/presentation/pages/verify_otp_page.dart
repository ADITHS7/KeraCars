import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:keracars_app/core/error/network_exception.dart';
import 'package:keracars_app/features/auth/data/models/otp_login_model.dart';
import 'package:keracars_app/features/auth/presentation/blocs/blocs.dart';
import 'package:keracars_app/features/auth/presentation/widgets/widgets.dart';

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({super.key, required LoginBloc bloc}) : _bloc = bloc;

  final LoginBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: const _VerifyOTPPage(),
    );
  }
}

class _VerifyOTPPage extends StatelessWidget {
  const _VerifyOTPPage();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is SignInRequestSuccess) {
          GetIt.I<AuthBloc>().add(AddAuthentication(state.newAuth));
        } else if (state is OTPRequestSuccess && state.exception != null) {
          ErrorAlertDialog.show(
            context,
            contentText: (state.exception as NetworkException).message ?? "Error",
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              final state = context.read<LoginBloc>().state as OTPRequestSuccess;
              context.read<LoginBloc>().add(EditNumber(state.requestOTP));
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  void _submitOtp(BuildContext context, {required String otp}) {
    final state = context.read<LoginBloc>().state;

    if (state is OTPRequestSuccess) {
      final otpLogin = OTPLoginModel(
        id: state.otpId,
        otp: otp,
      );

      context.read<LoginBloc>().add(RequestSignIn(otpLogin));
    }
  }

  Widget _buildBody(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final TextEditingController controller = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "OTP Verification",
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            _subheader(context),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                final state = context.read<LoginBloc>().state as OTPRequestSuccess;
                context.read<LoginBloc>().add(EditNumber(state.requestOTP));
                context.go(context.namedLocation('login'));
              },
              child: Text(
                "Edit number",
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 16),
            OTPField(
              onSubmit: (value) {
                controller.text = value;
                _submitOtp(context, otp: value);
              },
            ),
            const SizedBox(height: 36),
            Center(
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return CTAButton(
                    text: state is SignInRequestLoading ? "Processing..." : "Verify",
                    onPressed: state is! SignInRequestLoading ? () => _submitOtp(context, otp: controller.text) : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: OTPTimeout(
                requestOTP: (context.read<LoginBloc>().state as OTPRequestSuccess).requestOTP,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subheader(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final phoneNumber = (context.read<LoginBloc>().state as OTPRequestSuccess).requestOTP.credential;

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "We have sent a "),
          TextSpan(
            text: "One Time Password ",
            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
          ),
          const TextSpan(text: "to your mobile number. +91"),
          TextSpan(text: "*****${phoneNumber.substring(phoneNumber.length - 3)}"),
        ],
        style: theme.textTheme.titleMedium?.copyWith(color: theme.disabledColor),
      ),
      textAlign: TextAlign.center,
    );
  }
}
