import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../widgets/sort_item.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Projects",
                    style: TextStyle(
                      color: Color.fromRGBO(20, 20, 20, 1),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(25),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SortItem(index: 0, text: "To do"),
                        SortItem(index: 1, text: "In process"),
                        SortItem(index: 2, text: "Done"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => const TaskItem(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Colors.transparent,
        height: 100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(33, 33, 33, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => GoRouter.of(context).replace("/add-task"),
                icon: const Icon(
                  Icons.home_filled,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () => GoRouter.of(context).replace("/notes"),
                icon: const Icon(
                  Icons.note,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Transform(
                transform: Matrix4(
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                )
                  ..rotateX(120)
                  ..rotateY(25)
                  ..rotateZ(0),
                alignment: FractionalOffset.center,
                child: InkWell(
                  onTap: () => GoRouter.of(context).replace("/add-task"),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
