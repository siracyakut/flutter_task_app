import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutScreen extends StatefulWidget {
  final Widget child;
  const LayoutScreen({super.key, required this.child});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: widget.child,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Colors.transparent,
        height: 100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => context.push("/home"),
                icon: Icon(
                  Icons.home_filled,
                  color: Theme.of(context).colorScheme.background,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () => context.push("/profile"),
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.background,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () => context.push("/settings"),
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.background,
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
                  onTap: () => context.push("/add-task"),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onBackground,
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
