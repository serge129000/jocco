import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class AsynchronousLoader extends StatefulWidget {
  final double debut;
  final double finish;
  const AsynchronousLoader(
      {super.key, required this.finish, required this.debut});

  @override
  State<AsynchronousLoader> createState() => _AsynchronousLoaderState();
}

class _AsynchronousLoaderState extends State<AsynchronousLoader>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: widget.debut, end: widget.finish).animate(
      CurvedAnimation(parent: animationController, curve: Curves.ease),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1 / 0,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(30)),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(builder: (context, constraint) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                /* animation = Tween<double>(begin: 0.5, end: 0.70).animate(
                    CurvedAnimation(
                        parent: animationController, curve: Curves.ease),
                  );
                  animationController.forward(); */
              },
              child: Container(
                height: 1 / 0,
                color: PrimaryColors.white,
                width: (constraint.maxWidth * animation.value),
              ),
            ),
          ),
        );
      }),
    );
  }
}
