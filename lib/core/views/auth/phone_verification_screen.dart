import 'package:flutter/material.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/onboarding/onboarding.dart';
import 'package:jocco/core/views/widgets/back_widget.dart';
import 'package:pinput/pinput.dart';

import '../../utils/all_text.dart';
import '../../utils/color.dart';
import '../widgets/button.dart';
import '../widgets/custom_scaffold.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SizedBox(
      height: 1 / 0,
      width: 1 / 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(alignment: Alignment.topLeft, child: BackWidget()),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  AllText.verificationLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: PrimaryColors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  widget.phoneNumber,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.w600, color: whiteInClearGreen),
                ),
              ),
              Pinput(
                length: 5,
                submittedPinTheme: PinTheme(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: PrimaryColors.white,
                    fontWeight: FontWeight.w500
                  ),
                    height: 72,
                    width: 64.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: PrimaryColors.white))),
                focusedPinTheme: PinTheme(
                    height: 72,
                    width: 64.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: PrimaryColors.white))),
                defaultPinTheme: PinTheme(
                    height: 72,
                    width: 64.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: PrimaryColors.first))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 5),
                child: Text(
                  AllText.verificationCodeSub,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: PrimaryColors.white),
                ),
              ),
              Text(
                AllText.resend,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    decorationColor: PrimaryColors.first,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    color: PrimaryColors.first,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Btn(
                function: () {
                  kReplaceToPage(context, page: const Onboarding());
                },
                isTransparent: false,
                anotherColor: PrimaryColors.white,
                child: Text(
                  AllText.next,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: PrimaryColors.first, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
