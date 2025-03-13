import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/widgets/get_premium_component.dart';

class PremiumPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const PremiumPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              kIconAssetPath(imageName: data['icon']),
              height: 92,
            ),
          ),
          Text(
            data['title'],
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: PrimaryColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Text(
              data['sub'],
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: PrimaryColors.white),
            ),
          ),
          GetPremiumComponent(
            topTitle: data['data']['title'],
            subTitle: data['data']['sub'],
            details: data['data']['details'],
            price: 4.99,
            btnColor: data['color'] ?? firstPremiumBtnColor,
          )
        ],
      ),
    );
  }
}
