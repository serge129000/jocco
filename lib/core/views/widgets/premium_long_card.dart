import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';

import '../../utils/color.dart';
import 'button.dart';

class PremiumLongCard extends StatelessWidget {
  final String topTitle;
  final String subTitle;
  final Color btnColor;
  const PremiumLongCard({super.key, required this.topTitle, required this.subTitle, required this.btnColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1/0,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: premiumBackGroundColor),
      child: Column(
        children: [
          Text(
            topTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: PrimaryColors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: PrimaryColors.white),
            ),
          ),
          Btn(
              child: Text(AllText.explorePlan, style: TextStyle(
                    color: PrimaryColors.white
                  ),),
              isTransparent: false,
              anotherColor: btnColor,),
          
        ],
      ),
    );
  }
}