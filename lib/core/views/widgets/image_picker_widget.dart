import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 137.97,
      width: 109.62,
      decoration: BoxDecoration(
        color: PrimaryColors.first,
        border: Border.all(
          width: 1.5,
          color: pickerBorder
        ),
        borderRadius: BorderRadius.circular(
          10
        )
      ),
    );
  }
}