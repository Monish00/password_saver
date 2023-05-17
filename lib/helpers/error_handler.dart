import 'package:flutter/material.dart';

snackBarMessage(String? message, BuildContext? context) {
  if (message == null || context == null) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
