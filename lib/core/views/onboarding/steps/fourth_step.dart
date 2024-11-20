import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/another_selected_container.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/path.dart';
import '../../widgets/button.dart';

class FourthStep extends StatelessWidget {
  const FourthStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kAssetPath(imageName: 'Vector 1.png')),
                alignment: Alignment.topCenter)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 90,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //BackWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          kAssetPath(imageName: 'mind.png'),
                          height: 172.35,
                          width: 270.56,
                        ),
                      ),
                    ),
                    Image.asset(kAssetPath(imageName: 'Vector-2.png'))
                  ],
                ),
              ),
              Text(
                AllText.physictraits,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(height: 0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
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
                  anotherColor: PrimaryColors.first,
                  child: Text(
                    AllText.next,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: PrimaryColors.white,
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
