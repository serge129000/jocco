import 'package:flutter/material.dart';
import 'package:jocco/core/utils/path.dart';

class NoPotentialMatchComponents extends StatelessWidget {
  const NoPotentialMatchComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(kAssetPath(imageName: 'Magnifying_glass.png'), height: 70,),
        ],
      ),
    );
  }
}