// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  checkFirstLaunch() async {
    var storage = Storage();
    var isFirstLaunch = await storage.isFirstLaunch();
    if (isFirstLaunch != null) {
      GoRouter.of(context).replace("/home");
    } else {
      GoRouter.of(context).replace("/boarding");
    }
  }

  @override
  void initState() {
    checkFirstLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
