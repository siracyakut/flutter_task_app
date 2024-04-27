import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/localizations.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/boarding1.jpg"),
              const Gap(25),
              Text(
                "404 Not Found",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(25),
              ElevatedButton(
                onPressed: () => GoRouter.of(context).replace("/home"),
                child: Text(
                  AppLocalizations.of(context).getTranslate("go-home"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
