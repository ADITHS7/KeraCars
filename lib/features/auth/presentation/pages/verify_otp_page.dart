import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:keracars_app/features/auth/data/models/otp_login_model.dart';
import 'package:keracars_app/features/auth/presentation/blocs/blocs.dart';

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is SignInRequestSuccess) {
          GetIt.I<AuthBloc>().add(AddAuthentication(state.newAuth));
        }
      },
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final TextEditingController controller = TextEditingController();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: controller),
            const SizedBox(height: 36),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      final state = context.read<LoginBloc>().state;

                      final String otpId;

                      if (state is OTPRequestSuccess) {
                        otpId = state.otpId;
                      } else if (state is SignInRequestError) {
                        otpId = state.otpId;
                      } else {
                        otpId = '';
                      }

                      if (state is OTPRequestSuccess || state is SignInRequestError) {
                        context.read<LoginBloc>().add(
                              RequestSignIn(
                                OTPLoginModel(
                                  id: otpId,
                                  otp: controller.text,
                                ),
                              ),
                            );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Verify",
                        style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
