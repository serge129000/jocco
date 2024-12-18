import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class ColouredContainer extends StatelessWidget {
  final Widget child;
  const ColouredContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10
      ),
      decoration: BoxDecoration(
        color: PrimaryColors.second,
        borderRadius: BorderRadius.circular(20)
      ),
      child: child,
    );
  }
}
