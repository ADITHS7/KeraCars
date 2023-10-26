import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPField extends StatelessWidget {
  const OTPField({
    super.key,
    required this.onSubmit,
  });

  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final borderSide = BorderSide(
      color: theme.colorScheme.primary,
      width: 3,
      strokeAlign: BorderSide.strokeAlignCenter,
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: borderSide,
    );

    return SizedBox(
      height: 96,
      child: OtpTextField(
        margin: const EdgeInsets.all(0),
        filled: true,
        hasCustomInputDecoration: true,
        onSubmit: onSubmit,
        numberOfFields: 4,
        showCursor: false,
        autoFocus: true,
        fieldWidth: 75,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        decoration: InputDecoration(
          border: border,
          contentPadding: const EdgeInsets.symmetric(vertical: 24),
          enabledBorder: border.copyWith(
            borderSide: borderSide.copyWith(color: theme.colorScheme.primary.withAlpha(120)),
          ),
          focusedBorder: border,
          filled: true,
          fillColor: theme.colorScheme.primary.withAlpha(40),
          counterText: '',
        ),
      ),
    );
  }
}
