import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../bloc/client/client_cubit.dart';
import '../core/localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  String language = "";

  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    setState(() {
      language = clientCubit.getLanguage();
      darkMode = clientCubit.getTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        leading: IconButton(
          onPressed: () => context.go("/home"),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        title: Text(AppLocalizations.of(context).getTranslate("settings")),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).getTranslate("dark-mode")),
                  Switch(
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = !darkMode;
                        clientCubit.setTheme(newTheme: darkMode);
                      });
                    },
                  ),
                ],
              ),
              const Gap(10),
              Divider(color: Theme.of(context).colorScheme.onBackground),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).getTranslate("language")),
                  Row(
                    children: [
                      languageOption(
                        context,
                        AppLocalizations.of(context).getTranslate("english"),
                        "en",
                      ),
                      const Gap(20),
                      languageOption(
                        context,
                        AppLocalizations.of(context).getTranslate("turkish"),
                        "tr",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget languageOption(BuildContext context, String text, String code) {
    return GestureDetector(
      onTap: () {
        setState(() {
          language = code;
          clientCubit.setLanguage(newLanguage: code);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2,
          ),
          color: language == code
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: language == code
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
