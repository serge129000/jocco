import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/widgets/button.dart';

class GetPremiumComponent extends StatelessWidget {
  final String topTitle;
  final String subTitle;
  final List<String> details;
  final double price;
  final String? currency;
  final Color? btnColor;
  const GetPremiumComponent(
      {super.key,
      required this.topTitle,
      required this.subTitle,
      required this.details,
      required this.price,
      this.currency, this.btnColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context: context).width - 100,
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
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: PrimaryColors.white),
            ),
          ),
          ...details.map((e) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: PrimaryColors.white,
                    size: 3,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        e,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: PrimaryColors.white,fontSize: 15),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Btn(
                child: Text(NumberFormat.currency(symbol: currency ?? '€')
                    .format(price), style: TextStyle(
                      color: PrimaryColors.white
                    ),),
                isTransparent: false,
                anotherColor: btnColor,),
          )
        ],
      ),
    );
  }
}
