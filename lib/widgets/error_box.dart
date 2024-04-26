import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorBox extends StatelessWidget {
  final String text;

  const ErrorBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red[400]!),
        borderRadius: BorderRadius.circular(15),
        color: Colors.red[100],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 25,
            color: Colors.red,
          ),
          const Gap(10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
