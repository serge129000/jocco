import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';

class StepLinearProgress extends StatelessWidget {
  final double value;
  const StepLinearProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 7.31,
          decoration: BoxDecoration(
            color: PrimaryColors.white,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value,
              child: LayoutBuilder(builder: (context, constraint) {
                /* print(constraint.maxWidth);
                print((size(context: context) / 13).width); */
                return AnimatedContainer(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 200),
                  height: 07.31,
                  decoration: BoxDecoration(
                      color: constraint.maxWidth > size(context: context).width/2
                          ? null
                          : PrimaryColors.first,
                      gradient:
                          constraint.maxWidth > size(context: context).width/2
                              ? const LinearGradient(colors: [
                                  PrimaryColors.first,
                                  PrimaryColors.gradientF
                                ])
                              : null),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
