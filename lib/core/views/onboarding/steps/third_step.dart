import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/list_utils.dart';
import '../../../utils/screen.dart';
import '../../../utils/step_utils.dart';
import '../../widgets/another_selected_container.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class ThirdStep extends StatelessWidget {
  const ThirdStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 110,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: BackWidget(
                onCondtion: () {
                  if (Provider.of<StepProvider>(context, listen: false)
                          .currentStep !=
                      StepJ.first) {
                    Provider.of<StepProvider>(context, listen: false)
                        .backStep();
                  } else {
                    kPopPage(context);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                AllText.physictraits,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    height: 0,
                    fontWeight: FontWeight.w600,
                    color: PrimaryColors.white),
              ),
            ),
            Wrap(
              runSpacing: 10,
              spacing: 12,
              children: [
                ...traitsDePersonnalite.map((e) => GestureDetector(
                      onTap: () {
                        if (stepProvider.selectedTraits.contains(e)) {
                          stepProvider.deleteTrait(trait: e);
                        } else {
                          stepProvider.addTraits(trait: e);
                        }
                      },
                      child: AnotherSelectedContainer(
                          isSelected: stepProvider.selectedTraits.contains(e),
                          child: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: PrimaryColors.white,
                                    fontSize: 14),
                          )),
                    ))
              ],
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
      );
    });
  }
}
