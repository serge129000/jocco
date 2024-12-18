import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/step_utils.dart';
import 'package:jocco/core/views/home/root.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/custom_textfield.dart';
import 'package:jocco/core/views/widgets/duration_chooser.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class SixthStep extends StatefulWidget {
  const SixthStep({super.key});

  @override
  State<SixthStep> createState() => _SixthStepState();
}

class _SixthStepState extends State<SixthStep> {
  bool hasNotProjectAndAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
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
                  AllText.hasProject,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 0,
                      fontWeight: FontWeight.w600,
                      color: PrimaryColors.white),
                ),
              ),
              Row(
                children: [
                  ...IfProject.values.map((e) => Row(
                        children: [
                          Radio<IfProject>(
                              activeColor: PrimaryColors.white,
                              fillColor: const WidgetStatePropertyAll(
                                  PrimaryColors.white),
                              value: stepProvider.selectedIfProject ??
                                  IfProject.yes,
                              groupValue: e,
                              onChanged: (v) {
                                stepProvider.setSelectedIfProjet(ifProject: e);
                              }),
                          Text(
                            e.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: PrimaryColors.white),
                          )
                        ],
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(AllText.titleProject,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white)),
              ),
              CustomTextfield(
                isActivate: stepProvider.selectedIfProject?.value ?? true,
                hasGreenColor: true,
                hintText: 'Saisir le titre de votre projet',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  AllText.specifyTitleProject,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 0,
                      fontWeight: FontWeight.w600,
                      color: PrimaryColors.white),
                ),
              ),
              CustomTextfield(
                isActivate: stepProvider.selectedIfProject?.value ?? true,
                hasGreenColor: true,
                hintText: 'Ex : Ouvrir un hôtel écologique en montagne',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(AllText.projectTimes,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white)),
              ),
              DurationChooser(
                isActivated: stepProvider.selectedIfProject?.value ?? true,
                onChanged: (p0) {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  AllText.leaveAll,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 0,
                      fontWeight: FontWeight.w600,
                      color: PrimaryColors.white),
                ),
              ),
              Row(
                children: [
                  ...LeaveAll.values.map((e) => Row(
                        children: [
                          Radio<LeaveAll>(
                              activeColor: PrimaryColors.white,
                              fillColor: const WidgetStatePropertyAll(
                                  PrimaryColors.white),
                              value: stepProvider.leaveAll,
                              groupValue: e,
                              onChanged: (v) {
                                stepProvider.setSelectedLeavingAll(
                                    leaveAlls: e);
                              }),
                          Text(
                            e.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: PrimaryColors.white),
                          )
                        ],
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Btn(
                  function: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            confirmFinalProject(context: context));
                    /* context.read<StepProvider>().nextStep(); */
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

  Widget confirmFinalProject({required BuildContext context}) =>
      StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: PrimaryColors.first,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Vous n\'avez pas de projet spécifique. Toutefois, veuillez confirmer votre engagement à respecter le projet des personnes dans la catégorie choisie.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: PrimaryColors.white, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Checkbox.adaptive(
                      fillColor:
                          const WidgetStatePropertyAll(PrimaryColors.first),
                      focusColor: PrimaryColors.first,
                      activeColor: PrimaryColors.first,
                      side: const BorderSide(color: PrimaryColors.white),
                      value: hasNotProjectAndAccepted,
                      onChanged: (v) {
                        setState(() {
                          hasNotProjectAndAccepted = !hasNotProjectAndAccepted;
                        });
                      }),
                  Expanded(
                    child: Text(
                      'Je m\'engage à respecter mon projet dans cette catégorie.',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 14,
                          color: PrimaryColors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                        width: size(context: context).width / 3.6,
                        child: Btn(
                            isTransparent: true,
                            function: () {
                              kPopPage(context);
                            },
                            child: Text(
                              'Annuler',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: PrimaryColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                            ))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Btn(
                            isTransparent: false,
                            function: () {
                              kPopPage(context);
                              kPushAndRemoveUntil(context, page: Root());
                            },
                            child: Text(
                              'Confirmer',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: PrimaryColors.first,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                            )))
                  ],
                ),
              )
            ],
          ),
        );
      });
}
