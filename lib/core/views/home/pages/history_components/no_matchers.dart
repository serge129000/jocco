import 'package:flutter/material.dart';
import 'package:jocco/core/utils/path.dart';

import '../../../../utils/all_text.dart';
import '../../../../utils/color.dart';

class NoMatchers extends StatelessWidget {
  const NoMatchers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                AllText.findHereMatched,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: PrimaryColors.white),
              ),
            ),
        Expanded(child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(kIconAssetPath(imageName: 'hrtbrk.png')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                AllText.noMatch,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 25,
                    color: PrimaryColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )))
      ],
    );
  }
}