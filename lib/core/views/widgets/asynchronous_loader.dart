import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class AsynchronousLoader extends StatefulWidget {
  final double debut;
  final double finish;
  final String? stepMessage;
  const AsynchronousLoader(
      {super.key, required this.finish, required this.debut, this.stepMessage});

  @override
  State<AsynchronousLoader> createState() => _AsynchronousLoaderState();
}

class _AsynchronousLoaderState extends State<AsynchronousLoader>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  String? stepMessage = 'En cours';
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    setupAnimation(widget.debut, widget.finish);
    super.initState();
    animationController.forward();
  }

  void setupAnimation(double debut, double fin) {
    animation = Tween<double>(begin: debut, end: fin).animate(
      CurvedAnimation(parent: animationController, curve: Curves.ease),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(covariant AsynchronousLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.debut != oldWidget.debut || widget.finish != oldWidget.finish) {
      // Arrête l'animation en cours
      animationController.stop();
      // Réinitialise le contrôleur avec les nouvelles valeurs
      setState(() {
        stepMessage = widget.stepMessage;
      });
      setupAnimation(animation.value, widget.finish);
      animationController.forward(from: 0); // Redémarre depuis le début
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
                child: Container(
                  height: 1 / 0,
                  color: PrimaryColors.white,
                  width: (constraint.maxWidth * animation.value),
                ),
              ),
            );
          }),
        ),
        Center(
          child: Text(
            '${stepMessage} (${(animation.value * 100).toInt()})%',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: PrimaryColors.first, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
