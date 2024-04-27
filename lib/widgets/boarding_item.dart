import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../core/localizations.dart';

class BoardingItem extends StatefulWidget {
  final String title;
  final String imagePath;
  final bool isLast;
  final Function skipFunc;

  const BoardingItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isLast,
    required this.skipFunc,
  });

  @override
  State<BoardingItem> createState() => _BoardingItemState();
}

class _BoardingItemState extends State<BoardingItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imagePath),
            const Gap(25),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const Gap(25),
            InkWell(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 25,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                child: InkWell(
                  onTap: () {
                    if (widget.isLast) {
                      GoRouter.of(context).replace("/home");
                    } else {
                      widget.skipFunc();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isLast
                            ? AppLocalizations.of(context)
                                .getTranslate("complete")
                            : AppLocalizations.of(context)
                                .getTranslate("continue"),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 50,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(20),
            InkWell(
              onTap: () => GoRouter.of(context).replace("/home"),
              child: Text(
                AppLocalizations.of(context).getTranslate("skip"),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
