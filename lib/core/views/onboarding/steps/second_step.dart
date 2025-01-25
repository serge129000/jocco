import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/image_picker_widget.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';
import '../../../utils/step_utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Container(
        alignment: Alignment.topCenter,
        child: Padding(
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(AllText.showBestFace,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white)),
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 10,
                  spacing: 7,
                  children: [
                    ...List<int>.generate(6, (i) => i)
                        .map((e) => ImagePickerWidget(
                              onImageChanged: (value) {
                                if (value == null) {
                                  stepProvider.removeImage(key: e);
                                } else {
                                  stepProvider.addImage(key: e, imagePath: value);
                                }
                              },
                            ))
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Btn(
                  function: () {
                    if (stepProvider.selectedImages.entries.length < 3) {
                      showSnackbar(
                          context: context,
                          isError: true,
                          content: Text('Choisissez au moins 3 photos', style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: PrimaryColors.white
                          ),));
                    } else
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
