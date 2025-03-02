import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/widgets/button.dart';

import '../../../../utils/screen.dart';
import 'filter.dart';

class NoPotentialMatchComponents extends StatelessWidget {
  const NoPotentialMatchComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            kAssetPath(imageName: 'Magnifying_glass.png'),
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              AllText.noProfil,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: PrimaryColors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Btn(
              function: () {
                HapticFeedback.mediumImpact();
                kPushToPage(context, page: Filter());
              },
              child: Text(
                AllText.updateFilter,
                style: TextStyle(color: PrimaryColors.white),
              ),
              isTransparent: false,
              anotherColor: firstPremiumBtnColor,
            ),
          )
        ],
      ),
    );
  }
}
