import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../core/localizations.dart';
import '../models/task.dart';
import 'textbox.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    List<String> priorityList = [
      AppLocalizations.of(context).getTranslate("asap"),
      AppLocalizations.of(context).getTranslate("high"),
      AppLocalizations.of(context).getTranslate("medium"),
      AppLocalizations.of(context).getTranslate("low")
    ];

    List<String> statusList = [
      AppLocalizations.of(context).getTranslate("todo"),
      AppLocalizations.of(context).getTranslate("in-process"),
      AppLocalizations.of(context).getTranslate("done")
    ];

    return GestureDetector(
      onTap: () {
        context.goNamed("edit-task", pathParameters: {"id": task.id});
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: HexColor.fromHex(task.color),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    task.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: HexColor.fromHex(getHSL(task.color)),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                TextBox(text: statusList.elementAt(task.status)),
              ],
            ),
            const Gap(15),
            Text(
              task.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                color: HexColor.fromHex(getHSL(task.color)),
                fontSize: 16,
              ),
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.date,
                  style: TextStyle(color: HexColor.fromHex(getHSL(task.color))),
                ),
                TextBox(text: priorityList.elementAt(task.priority)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ChatGPT
String getHSL(String color) {
  int hsl = ((int.parse(color.substring(0, 2), radix: 16) * 299 +
              int.parse(color.substring(2, 4), radix: 16) * 587 +
              int.parse(color.substring(4, 6), radix: 16) * 114) /
          1000)
      .round();

  return hsl > 128 ? "#000000" : "#ffffff";
}

// https://stackoverflow.com/a/71005636
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${alpha.toRadixString(16).padLeft(2, '0')}';
}
