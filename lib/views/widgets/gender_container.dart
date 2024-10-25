import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class GenderContainer extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  const GenderContainer({super.key, required this.isSelected, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 1 / 0,
      decoration: BoxDecoration(
        color: isSelected? filledSelectedBorder: null,
          border: Border.all(color: isSelected? selectedBorderColor: borderColor),
          borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
