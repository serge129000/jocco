import 'package:flutter/material.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';

class MiniUserCircleAvatar extends StatelessWidget {
  final String url;
  final double? customSize;
  const MiniUserCircleAvatar({super.key, required this.url, this.customSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customSize ?? 59,
      width: customSize ?? 59,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: CustomImageShower(
        url: url,
        isRounded: true,
      ),
    );
  }
}
