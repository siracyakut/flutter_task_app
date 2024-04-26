import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dialogs {
  errorDialog({required BuildContext context, required String text}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error),
        title: const Text("Error"),
        content: Text(text),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  infoDialog({
    required BuildContext context,
    required String text,
    required bool navigate,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Info"),
        content: Text(text),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (navigate) GoRouter.of(context).replace("/home");
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
