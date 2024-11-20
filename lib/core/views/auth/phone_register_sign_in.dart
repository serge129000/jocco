import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/models/country.dart';
import 'package:jocco/core/views/auth/phone_verification_screen.dart';
import 'package:jocco/core/views/widgets/back_widget.dart';
import 'package:jocco/core/views/widgets/button.dart';
import 'package:jocco/core/views/widgets/custom_phone_picker.dart';
import 'package:jocco/core/views/widgets/custom_textfield.dart';

import '../../utils/country_list.dart';
import '../widgets/custom_scaffold.dart';

class PhoneRegisterSignIn extends StatefulWidget {
  const PhoneRegisterSignIn({super.key});

  @override
  State<PhoneRegisterSignIn> createState() => _PhoneRegisterSignInState();
}

class _PhoneRegisterSignInState extends State<PhoneRegisterSignIn> {
  FocusNode phoneFocus = FocusNode();
  String phoneNumber = '';
  Country? selectedCountry = Countries.countryList
      .map((e) => Country.fromJson(e))
      .toList()
      .where((e) => e.name!.toLowerCase().contains('france'))
      .single;
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
            children: [
              const Align(alignment: Alignment.topLeft, child: BackWidget()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  AllText.enterEmail,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(height: 0, fontWeight: FontWeight.w600, color: PrimaryColors.white),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomPhonePicker(
                      onChanged: (selectedCountry) {},
                    ),
                  ),
                  Expanded(
                      child: CustomTextfield(
                        hasGreenColor: true,
                    onChanged: (p0) {
                      setState(() {
                        phoneNumber = '${selectedCountry!.dialCode} $p0';
                      });
                    },
                    focusNode: phoneFocus,
                    keyboardType: TextInputType.phone,
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: Text(
                  AllText.enterPhoneSub,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontWeight: FontWeight.w500, color: PrimaryColors.white),
                ),
              ),
              const Spacer(),
              Btn(
                function: () {
                  kReplaceToPage(context,
                      page: PhoneVerificationScreen(
                        phoneNumber: phoneNumber,
                      ));
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
