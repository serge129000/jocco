import 'package:flutter/material.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';

class UltraMiniUserCircleAvatar extends StatelessWidget {
  final String url;
  const UltraMiniUserCircleAvatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: CustomImageShower(url: url),
    );
  }
}
