import 'package:flutter/material.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';

class MiniUserCircleAvatar extends StatelessWidget {
  final String url;
  const MiniUserCircleAvatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      width: 59,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: CustomImageShower(url: url),
    );
  }
}
