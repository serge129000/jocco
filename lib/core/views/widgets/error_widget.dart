import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/views/widgets/button.dart';

import '../../utils/color.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function() onRetry;
  const CustomErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AllText.errorT,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 25,
              color: PrimaryColors.white,
              fontWeight: FontWeight.bold),
        ),
        Padding(padding: const EdgeInsets.symmetric(
          vertical: 10
        ),
        child: Text(
          AllText.whyError,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 18,
              color: PrimaryColors.white,
              ),
        ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50
          ),
          child: Btn(child: Text(
            AllText.retry,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 18,
                color: PrimaryColors.white,
                ),
          ), isTransparent: false, anotherColor: firstPremiumBtnColor, function: onRetry,),
        )
      ],
    ));
  }
}
