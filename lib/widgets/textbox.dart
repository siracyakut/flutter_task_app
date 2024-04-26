import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;

  const TextBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
          width: 2,
        ),
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
