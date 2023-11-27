import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:keracars_app/config/routes/route_name.dart";
import "package:keracars_app/core/error/network_exception.dart";
import "package:keracars_app/features/auth/blocs/blocs.dart";
import "package:keracars_app/features/auth/data/models/otp_login_model.dart";
import "package:keracars_app/features/auth/presentation/widgets/widgets.dart";

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({
    super.key,
    required String otpId,
    required LoginBloc loginBloc,
  })  : _otpId = otpId,
        _loginBloc = loginBloc;

  final String _otpId;
  final LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: GetIt.I<VerifyOtpBloc>()..add(VerifyOtpInit(otpId: _otpId)),
        ),
        BlocProvider.value(
          value: _loginBloc,
        ),
      ],
      child: const _VerifyOTPPage(),
    );
  }
}

class _VerifyOTPPage extends StatelessWidget {
  const _VerifyOTPPage();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocListener<VerifyOtpBloc, VerifyOtpState>(
      listener: (_, state) {
        if (state is SignInRequestSuccess) {
          GetIt.I<AuthBloc>().add(AddAuthentication(state.newAuth));
        } else if (state is SignInRequestError && state.exception != null) {
          ErrorAlertDialog.show(
            context,
            contentText: (state.exception as NetworkException).message ?? "Error",
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
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
    final state = context.read<VerifyOtpBloc>().state;

    final otpLogin = OTPLoginModel(
      id: state.otpId,
      otp: otp,
    );

    context.read<VerifyOtpBloc>().add(RequestSignIn(otpLogin));
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
              onTap: () => context.goNamed(RouteName.login),
              child: Text(
                "Edit number",
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 16),
            OTPField(
              controller: controller,
              onSubmit: (value) => _submitOtp(context, otp: value),
            ),
            const SizedBox(height: 36),
            Center(
              child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                builder: (context, state) {
                  return CTAButton(
                    text: state is SignInRequestLoading ? "Processing..." : "Verify",
                    onPressed: state is! SignInRequestLoading ? () => _submitOtp(context, otp: controller.text) : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 36),
            const Center(
              child: OTPTimer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subheader(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final phone = (context.read<LoginBloc>().state as OTPRequestSuccess).requestOTPModel.credential;

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "We have sent a "),
          TextSpan(
            text: "One Time Password ",
            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
          ),
          const TextSpan(text: "to your mobile number. +91"),
          TextSpan(text: "*****${phone.substring(phone.length - 3)}"),
        ],
        style: theme.textTheme.titleMedium?.copyWith(color: theme.disabledColor),
      ),
      textAlign: TextAlign.center,
    );
  }
}
