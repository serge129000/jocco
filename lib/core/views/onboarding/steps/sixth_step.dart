import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/step_utils.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/selectable_container.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/path.dart';
import '../../widgets/button.dart';

class SixthStep extends StatelessWidget {
  const SixthStep({super.key});

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
                      padding: const EdgeInsets.only(top: 25),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          kAssetPath(imageName: 'plan_life_1.png'),
                          height: 245.03,
                          width: 228.42,
                        ),
                      ),
                    ),
                    Image.asset(kAssetPath(imageName: 'Vector-2.png'))
                  ],
                ),
              ),
              Text(
                AllText.hasProject,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(height: 0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              ...IfProject.values.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        stepProvider.setSelectedIfProjet(ifProject: e);
                      },
                      child: SelectableContainer(
                          isSelected: stepProvider.selectedIfProject == e,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                              child: Text(
                                e.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          )),
                    ),
                  )),
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
