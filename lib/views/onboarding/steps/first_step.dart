import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/views/providers/step_provider.dart';
import 'package:jocco/views/widgets/custom_textfield.dart';
import 'package:jocco/views/widgets/date_selector.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color.dart';
import '../../../core/utils/path.dart';
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //BackWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        kAssetPath(imageName: 'Documents.png'),
                        height: 174.24,
                        width: 157.26,
                      ),
                    ),
                  ),
                  Image.asset(kAssetPath(imageName: 'Vector-2.png'))
                ],
              ),
            ),
            Text(
              AllText.enterFistname,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(height: 0, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomTextfield(
                hintText: AllText.firstnameLabel,
              ),
            ),
            Text(
              AllText.enterBirthDay,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(height: 0, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DatePickerWidget(
                  onChange: (v, e) {
                    setState(() {
                      selectedDate = '${v.day}/${v.month}/${v.year}';
                    });
                  },
                  dateFormat: selectedDate),
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
                      color: PrimaryColors.white, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
