import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../widgets/boarding_item.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<Map<String, String>> boardingData = [
    {
      "title": "Focus on the work that matters",
      "image": "assets/images/boarding1.jpg"
    },
    {
      "title": "Stay organized and efficient",
      "image": "assets/images/boarding2.jpg"
    },
    {
      "title": "Plan, manage and track tasks",
      "image": "assets/images/boarding3.jpg"
    }
  ];

  PreloadPageController pageController = PreloadPageController(
    initialPage: 0,
    keepPage: true,
  );

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.horizontal_rule,
              size: pageIndex == 0 ? 40 : 30,
              color: pageIndex == 0
                  ? Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.outline,
            ),
            Icon(
              Icons.horizontal_rule,
              size: pageIndex == 1 ? 40 : 30,
              color: pageIndex == 1
                  ? Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.outline,
            ),
            Icon(
              Icons.horizontal_rule,
              size: pageIndex == 2 ? 40 : 30,
              color: pageIndex == 2
                  ? Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PreloadPageView.builder(
          controller: pageController,
          itemCount: boardingData.length,
          preloadPagesCount: boardingData.length,
          onPageChanged: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          itemBuilder: (context, index) => BoardingItem(
            title: boardingData[index]["title"]!,
            imagePath: boardingData[index]["image"]!,
            isLast: (boardingData.length - 1) == index,
            skipFunc: () {
              pageController.animateToPage(
                index + 1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
          ),
        ),
      ),
    );
  }
}
