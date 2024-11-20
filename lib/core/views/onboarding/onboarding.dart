import 'package:flutter/material.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/onboarding/steps/fifth_step.dart';
import 'package:jocco/core/views/onboarding/steps/first_step.dart';
import 'package:jocco/core/views/onboarding/steps/fourth_step.dart';
import 'package:jocco/core/views/onboarding/steps/second_step.dart';
import 'package:jocco/core/views/onboarding/steps/sixth_step.dart';
import 'package:jocco/core/views/onboarding/steps/third_step.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/back_widget.dart';
import 'package:jocco/core/views/widgets/custom_scaffold.dart';
import 'package:jocco/core/views/widgets/step_linear_progress.dart';
import 'package:provider/provider.dart';

import '../../utils/step_utils.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SizedBox(
            height: 1 / 0,
            width: 1 / 0,
            /* decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(kAssetPath(imageName: 'frame-2.png')))), */
            child: Stack(
              children: [
                Consumer<StepProvider>(
                    builder: (context, stepProvider, widget) {
                  switch (stepProvider.currentStep) {
                    case StepJ.first:
                      return const FirstStep();
                    case StepJ.second:
                      return const SecondStep();
                    case StepJ.third:
                      return const ThirdStep();
                    case StepJ.fourth:
                      return const FourthStep();
                    case StepJ.fifth:
                      return const FifthStep();
                    case StepJ.sixth:
                      return const SixthStep();
                    default:
                      return const SizedBox();
                  }
                }),
                Positioned(
                  top: size(context: context).height / 16,
                  child: SizedBox(
                      width: size(context: context).width,
                      child: StepLinearProgress(
                          value:
                              context.watch<StepProvider>().currentStep.value /
                                  13)),
                ),
                Positioned(
                  top: size(context: context).height / 9,
                  left: 20,
                  child: BackWidget(
                    onCondtion: () {
                      if (Provider.of<StepProvider>(context, listen: false).currentStep !=
                          StepJ.first) {
                        Provider.of<StepProvider>(context, listen: false).backStep();
                      } else {
                        kPopPage(context);
                      }
                    },
                  ),
                )
              ],
            )));
  }
}
