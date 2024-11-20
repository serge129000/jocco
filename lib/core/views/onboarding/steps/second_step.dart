import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../widgets/button.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 110,
              ),
              Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(AllText.showBestFace,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    height: 0,
                    fontWeight: FontWeight.w600,
                    color: PrimaryColors.white)),
          ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Btn(
                  function: () {
                    context.read<StepProvider>().nextStep();
                  },
                  isTransparent: false,
                  anotherColor: PrimaryColors.white,
                  child: Text(
                    AllText.next,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: PrimaryColors.first,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
