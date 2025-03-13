import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/gender.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/custom_textfield.dart';
import 'package:jocco/core/views/widgets/date_selector.dart';
import 'package:jocco/core/views/widgets/department_selector.dart';
import 'package:provider/provider.dart';

import '../../../models/country.dart';
import '../../../utils/color.dart';
import '../../../utils/country_list.dart';
import '../../../utils/screen.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class FirstStep extends StatefulWidget {
  final bool hasNotSizedBox;
  const FirstStep({super.key, this.hasNotSizedBox = false});

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  String selectedDate = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
      nameController.text =
          Provider.of<StepProvider>(context, listen: false).name ?? Provider.of<AppAuthProvider>(context, listen: false)
              .currentAppUser
              ?.prenom ??
          '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<StepProvider, AppAuthProvider>(builder: (context, stepProvider, appAuthProvider, widgets) {
      return Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            if (!widget.hasNotSizedBox)
              const SizedBox(
                height: 110,
              ),
            if (widget.hasNotSizedBox)
              Align(
                alignment: Alignment.centerLeft,
                child: BackWidget(
                  onCondtion: () {
                    kPopPage(context);
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
                                  value: stepProvider.selectedGender ?? Gender.fromSymbol(appAuthProvider.currentAppUser!.genre ?? Gender.male.symbol),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CustomTextfield(
                controller: nameController,
                onChanged: (p0) {
                  stepProvider.setName(name: p0);
                },
                hasGreenColor: true,
                hintText: AllText.firstnameLabel,
                validator: (p0) {
                  if (p0!.isEmpty || p0.length < 3) {
                    return 'Entrer un nom correct';
                  }
                  return null;
                },
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
                child: Consumer<AppAuthProvider>(
                    builder: (context, appAuthProvider, widgets) {
                  return DepartmentSelector(
                    countryName: Countries.countryList
                        .map((e) => Country.fromJson(e))
                        .toList()
                        .where((e) => e.alpha2Code!.toLowerCase().contains(
                            appAuthProvider.currentLocale?.toLowerCase() ??
                                'fr'))
                        .single
                        .name,
                    onChanged: (v) {
                      stepProvider.setDepartment(departement: v);
                    },
                  );
                })),
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
                        selectedDate = DateFormat('dd/MM/yyyy').format(v);
                      });
                      stepProvider.setBirthDate(birth: v);
                    },
                    dateFormat: selectedDate.isEmpty? stepProvider.birthDate != null? DateFormat('dd/MM/yyyy').format(stepProvider.birthDate!): appAuthProvider.currentAppUser?.dateNais != null? DateFormat('dd/MM/yyyy').format(appAuthProvider.currentAppUser!.dateNais!): selectedDate: selectedDate),
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
                                      stepProvider.choosenGender ?? Gender.male,
                                  groupValue: e,
                                  onChanged: (v) {
                                    stepProvider.setChoosenGender(gender: e);
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
            if (!widget.hasNotSizedBox)
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Btn(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      print(stepProvider.department);
                      if (stepProvider.department == null ||
                          stepProvider.birthDate == null) {
                        showSnackbar(
                            context: context,
                            isError: true,
                            content: Text(
                              'Veuillez renseigner tous les champs.',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: PrimaryColors.white),
                            ));
                      } else {
                        context.read<StepProvider>().nextStep();
                      }
                    }
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
              ),
          ],
        ),
      );
    });
  }
}
