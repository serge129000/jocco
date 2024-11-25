import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/gender.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/custom_textfield.dart';
import 'package:jocco/core/views/widgets/date_selector.dart';
import 'package:jocco/core/views/widgets/department_selector.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';
import '../../../utils/step_utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class FirstStep extends StatefulWidget {
  const FirstStep({super.key});

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  String selectedDate = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        //crossAxisAlignment: CrossAxisAlignment.start,
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
                  Provider.of<StepProvider>(context, listen: false).backStep();
                } else {
                  kPopPage(context);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(AllText.iam,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    height: 0,
                    fontWeight: FontWeight.w600,
                    color: PrimaryColors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                ...Gender.values
                    .where((e) => e.correspondingImage != null)
                    .map((e) => Row(
                          children: [
                            Radio<Gender>(
                                activeColor: PrimaryColors.white,
                                fillColor: const WidgetStatePropertyAll(
                                    PrimaryColors.white),
                                value:
                                    stepProvider.selectedGender ?? Gender.male,
                                groupValue: e,
                                onChanged: (v) {
                                  stepProvider.setGender(gender: e);
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
          ),
          Text(
            AllText.enterFistname,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0,
                fontWeight: FontWeight.w600,
                color: PrimaryColors.white),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CustomTextfield(
              hasGreenColor: true,
              hintText: AllText.firstnameLabel,
            ),
          ),
          Text(
            AllText.selectDepartment,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0,
                fontWeight: FontWeight.w600,
                color: PrimaryColors.white),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DepartmentSelector(
                onChanged: (v) {},
              )),
          Text(
            AllText.enterBirthDay,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0,
                fontWeight: FontWeight.w600,
                color: PrimaryColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DatePickerWidget(
                  onChange: (v, e) {
                    setState(() {
                      selectedDate = '${v.day}/${v.month}/${v.year}';
                    });
                  },
                  dateFormat: selectedDate),
            ),
          ),
          Text(
            AllText.hasChild,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0,
                fontWeight: FontWeight.w600,
                color: PrimaryColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                ...[true, false].map((e) => Row(
                      children: [
                        Radio<bool>(
                            activeColor: PrimaryColors.white,
                            fillColor: const WidgetStatePropertyAll(
                                PrimaryColors.white),
                            value: stepProvider.hasChildren,
                            groupValue: e,
                            onChanged: (v) {
                              stepProvider.changeHasChildrenState(e);
                            }),
                        Text(
                          e ? 'Oui' : 'Non',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: PrimaryColors.white),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Text(
            AllText.searchingFor,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0,
                fontWeight: FontWeight.w600,
                color: PrimaryColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                ...Gender.values
                    .where((e) => e.correspondingImage != null)
                    .map((e) => Row(
                          children: [
                            Radio<Gender>(
                                activeColor: PrimaryColors.white,
                                fillColor: const WidgetStatePropertyAll(
                                    PrimaryColors.white),
                                value:
                                    stepProvider.selectedGender ?? Gender.male,
                                groupValue: e,
                                onChanged: (v) {
                                  stepProvider.setGender(gender: e);
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Btn(
              function: () {
                context.read<StepProvider>().nextStep();
              },
              isTransparent: false,
              anotherColor: PrimaryColors.white,
              child: Text(
                AllText.next,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: PrimaryColors.first, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      );
    });
  }
}
