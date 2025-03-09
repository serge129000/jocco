import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/another_selected_container.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';
import '../../../utils/step_utils.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class FourthStep extends StatefulWidget {
  final bool hasNotSizedBox;
  const FourthStep({super.key, this.hasNotSizedBox = false});

  @override
  State<FourthStep> createState() => _FourthStepState();
}

class _FourthStepState extends State<FourthStep> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (Provider.of<StepProvider>(context, listen: false)
          .selectedInterest
          .isEmpty) {
        Provider.of<AppAuthProvider>(context, listen: false)
            .currentAppUser!
            .centreInterets
            .forEach((vl) {
          Provider.of<StepProvider>(context, listen: false)
              .addInterest(interest: vl ?? '');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.hasNotSizedBox)
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
                AllText.interestCenters,
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
                ...centresDInteret.map((e) => GestureDetector(
                      onTap: () {
                        if (stepProvider.selectedInterest.contains(e)) {
                          stepProvider.deleteInterest(interest: e);
                        } else {
                          if (!(stepProvider.selectedInterest.length < 3 &&
                              stepProvider.selectedInterest.length >= 1)) {
                            showSnackbar(
                                context: context,
                                isError: true,
                                content: Text(
                                  'Choisissez au maximum 3 passions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: PrimaryColors.white),
                                ));
                          } else {
                            stepProvider.addInterest(interest: e);
                          }
                        }
                      },
                      child: AnotherSelectedContainer(
                          isSelected: stepProvider.selectedInterest.contains(e),
                          child: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: borderColor,
                                    fontSize: 14),
                          )),
                    ))
              ],
            ),
            const Spacer(),
            if(!widget.hasNotSizedBox)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Btn(
                function: () {
                  if (stepProvider.selectedInterest.length <= 3 &&
                      stepProvider.selectedInterest.length >= 1) {
                    context.read<StepProvider>().nextStep();
                  } else {
                    showSnackbar(
                        context: context,
                        isError: true,
                        content: Text(
                          'Choisissez au maximum 3 passions',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: PrimaryColors.white),
                        ));
                  }
                },
                isTransparent: false,
                anotherColor: PrimaryColors.white,
                child: Text(
                  AllText.next,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: PrimaryColors.first, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
