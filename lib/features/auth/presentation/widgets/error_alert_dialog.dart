import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({super.key, required this.contentText});

  final String contentText;

  static FutureOr<dynamic> show(BuildContext context, {required String contentText}) {
    return showDialog(
      context: context,
      builder: (context) => ErrorAlertDialog(
        contentText: contentText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(
        contentText,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('OK'),
        )
      ],
    );
  }
}
