import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

import '../../utils/path.dart';
import '../../utils/screen.dart';

class BackWidget extends StatelessWidget {
  final Function()? onCondtion;
  const BackWidget({super.key, this.onCondtion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
          height: 24,
          width: 24,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: onCondtion ?? () {
                kPopPage(context);
              },
              child: Image.asset(
                kIconAssetPath(imageName: 'back.png'),
                height: 13.5,
                width: 6.75,
                color: PrimaryColors.white,
              ),
            ),
          )),
    );
  }
}
