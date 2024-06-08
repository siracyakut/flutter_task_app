import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/localizations.dart';

class Dialogs {
  errorDialog({required BuildContext context, required String text}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error),
        title: Text(AppLocalizations.of(context).getTranslate("error")),
        content: Text(text),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).getTranslate("ok")),
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
        title: Text(AppLocalizations.of(context).getTranslate("info")),
        content: Text(text),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (navigate) context.go("/home");
            },
            child: Text(AppLocalizations.of(context).getTranslate("ok")),
          ),
        ],
      ),
    );
  }
}
