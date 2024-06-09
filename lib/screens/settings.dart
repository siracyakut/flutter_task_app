import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).getTranslate("settings"),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Gap(30),
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
