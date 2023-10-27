import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    TextEditingController? controller,
    this.validator,
    this.onTap,
    this.helperText,
    this.prefixText,
    this.hintText,
    this.isNumberInput = false,
    this.onChanged,
    this.errorText,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
  }) : _controller = controller;

  final TextEditingController? _controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? helperText, prefixText, hintText, errorText;
  final int? maxLines, minLines;
  final bool isNumberInput;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;

  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final BorderSide borderSide = BorderSide(
      width: 2,
      strokeAlign: BorderSide.strokeAlignCenter,
      color: theme.colorScheme.primary,
    );

    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: borderSide,
    );

    return TextFormField(
      autofocus: autofocus,
      controller: _controller,
      onChanged: onChanged,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        border: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.disabledColor)),
        errorBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.colorScheme.error)),
        focusedBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.colorScheme.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        fillColor: theme.colorScheme.primary.withAlpha(40),
        isDense: true,
        focusedErrorBorder: inputBorder,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        helperText: helperText,
        hintText: hintText,
        errorText: errorText,
        counterText: ' ',
      ),
      keyboardType: isNumberInput ? const TextInputType.numberWithOptions(decimal: false) : null,
      inputFormatters: isNumberInput ? [FilteringTextInputFormatter.digitsOnly] : null,
      validator: validator,
    );
  }
}
