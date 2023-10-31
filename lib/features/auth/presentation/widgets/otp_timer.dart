import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";

class OTPTimer extends StatefulWidget {
  const OTPTimer({super.key});

  @override
  State<OTPTimer> createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {
  // ignore: unused_field
  late Timer _timer;
  final int _duration = 60;
  int _countdown = 0;
  // ignore: unused_field
  int _attempts = 0;

  String _time = "00:00";

  void startTimer() {
    _attempts++;
    _countdown = _duration + 1;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted) {
          setState(() {
            _countdown--;
            if (_countdown < 10) {
              _time = "00:0$_countdown";
            } else if (_countdown > 59) {
              _time = '0${(_countdown / 60).floor()}:${_countdown % 60 == 0 ? "00" : _countdown}';
            } else {
              _time = "00:$_countdown";
            }
            if (_countdown == 0) return timer.cancel();
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _time,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Didn't receive the code? "),
            InkWell(
              onTap: _countdown == 0
                  ? () {
                      final loginState = context.read<LoginBloc>().state;
                      context.read<LoginBloc>().add(
                            RequestOTP(
                              loginState.requestOTP.credential,
                              loginState.requestOTP.receiveUpdate,
                            ),
                          );
                      startTimer();
                    }
                  : null,
              child: Text(
                "Resend OTP",
                style: TextStyle(
                  color: _countdown == 0 ? theme.colorScheme.primary : theme.disabledColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
