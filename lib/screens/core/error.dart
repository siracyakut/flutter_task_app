import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/boarding1.jpg"),
              const Gap(25),
              const Text(
                "404 Not Found",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(25),
              ElevatedButton(
                onPressed: () => GoRouter.of(context).replace("/home"),
                child: const Text("Go Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
