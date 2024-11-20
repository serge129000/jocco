import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class AnotherSelectedContainer extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  const AnotherSelectedContainer({super.key, required this.isSelected, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15
      ),
      decoration: BoxDecoration(
        color: isSelected? filledSelectedBorder: null,
          border: Border.all(color: isSelected? selectedBorderColor: borderColor),
          borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}
