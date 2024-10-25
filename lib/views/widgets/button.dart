import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class Btn extends StatelessWidget {
  final Widget child;
  final void Function()? function;
  final bool isTransparent;
  final Color? anotherColor;
  const Btn(
      {super.key,
      required this.child,
      this.function,
      required this.isTransparent, this.anotherColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1 / 0,
      child: ElevatedButton(
          style: ButtonStyle(
              shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              backgroundColor: WidgetStatePropertyAll(
                  !isTransparent ? anotherColor ?? PrimaryColors.white : Colors.transparent),
              side: isTransparent
                  ? WidgetStatePropertyAll(
                      BorderSide(color: anotherColor ?? PrimaryColors.white))
                  : null),
          onPressed: function,
          child: child),
    );
  }
}
