import 'package:flutter/cupertino.dart';
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
import 'package:provider/provider.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import '../../utils/country_list.dart';
import '../widgets/custom_scaffold.dart';

class PhoneRegisterSignIn extends StatefulWidget {
  const PhoneRegisterSignIn({super.key});

  @override
  State<PhoneRegisterSignIn> createState() => _PhoneRegisterSignInState();
}

class _PhoneRegisterSignInState extends State<PhoneRegisterSignIn> {
  final key = GlobalKey<FormState>();
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
      child: Form(
        key: key,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomPhonePicker(
                        onChanged: (country) {
                          print(country?.dialCode);
                          setState(() {
                            selectedCountry = country;
                          });
                        },
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
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Numero incorrect';
                        }
                        return null;
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
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: PrimaryColors.white),
                  ),
                ),
                const Spacer(),
                Consumer<AuthProvider>(
                    builder: (context, authProvider, widgets) {
                  return Btn(
                    function: () async {
                      //print(phoneNumber.replaceAll(' ', '').trim());
                      if (key.currentState!.validate()) {
                        authProvider.verifyPhoneNumber(
                            phoneNumber: phoneNumber.replaceAll(' ', '').trim(),
                            verificationCompleted: (phoneAuthCredential) {
                              //print('completed');
                            },
                            verificationFailed: (firebaseAuthException) {
                              print(
                                  'Erreur : ${firebaseAuthException.message}');
                              print(
                                  'Code erreur : ${firebaseAuthException.credential}');
                            },
                            codeSent: (s, v) {
                              kReplaceToPage(context,
                                  page: PhoneVerificationScreen(
                                    phoneNumber: phoneNumber,
                                    id: s,
                                  ));
                            },
                            codeAutoRetrievalTimeout:
                                (codeAutoRetrievalTimeout) {});
                      }
                      /* kReplaceToPage(context,
                            page: PhoneVerificationScreen(
                              phoneNumber: phoneNumber,
                            )); */
                    },
                    isTransparent: false,
                    anotherColor: PrimaryColors.white,
                    child: Builder(builder: (context) {
                      return authProvider.registerStatus == Status.loading
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: PrimaryColors.first,
                              ),
                            )
                          : Text(
                              AllText.next,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: PrimaryColors.first,
                                      fontWeight: FontWeight.w600),
                            );
                    }),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
