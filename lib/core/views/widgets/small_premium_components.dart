import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';

class SmallPremiumComponents extends StatelessWidget {
  final Color? borderColor;
  final Map<String, dynamic> data;
  const SmallPremiumComponents({super.key, this.borderColor, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10
      ),
      height: 132,
      width: (size(context: context).width / 3) - 20,
      decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
              image: AssetImage(kIconAssetPath(imageName: 'stars.png'))),
          color: PrimaryColors.first,
          border: Border.all(color: borderColor ?? PrimaryColors.first),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Image.asset(kIconAssetPath(imageName: data['icon']), height: 45, width: 45,),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(data['simple'],textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: PrimaryColors.white,
                fontSize: 12.5
              ),),
            ),
          )
        ],
      ),
    );
  }
}
