import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/root.dart';
import 'package:jocco/core/views/onboarding/onboarding.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/widgets/back_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../utils/all_text.dart';
import '../../utils/color.dart';
import '../widgets/button.dart';
import '../widgets/custom_scaffold.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String id;
  const PhoneVerificationScreen(
      {super.key, required this.phoneNumber, required this.id});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  late AppAuthProvider authProvider;
  final formKey = GlobalKey<FormState>();
  String code = '';
  @override
  void initState() {
    authProvider = context.read<AppAuthProvider>();
    authProvider.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    authProvider.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SizedBox(
      height: 1 / 0,
      width: 1 / 0,
      child: Form(
        key: formKey,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    widget.phoneNumber,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600, color: whiteInClearGreen),
                  ),
                ),
                Pinput(
                  length: 6,
                  onChanged: (value) {
                    code = value;
                  },
                  submittedPinTheme: PinTheme(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: PrimaryColors.white,
                              fontWeight: FontWeight.w500),
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
                  validator: (value) {
                    if (authProvider.verifyingOtpStatus == Status.error) {
                      return 'Code incorrect';
                    }
                    if (value!.length < 6) {
                      return 'Code incomplet';
                    }
                    return '';
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Text(
                    AllText.verificationCodeSub,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: PrimaryColors.white),
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
                Consumer<AppAuthProvider>(
                    builder: (context, authProvider, widgets) {
                  return Btn(
                    function: () {
                      authProvider.verifyOtp(code: code, id: widget.id);
                    },
                    isTransparent: false,
                    anotherColor: PrimaryColors.white,
                    child: authProvider.verifyingOtpStatus == Status.loading
                        ? Center(
                            child: CupertinoActivityIndicator(
                            color: PrimaryColors.first,
                          ))
                        : Text(
                            AllText.next,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: PrimaryColors.first,
                                    fontWeight: FontWeight.w600),
                          ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void listener() {
    switch (authProvider.verifyingOtpStatus) {
      case Status.loaded:
        if (FirebaseAuth.instance.currentUser?.displayName == null) {
          kReplaceToPage(context, page: const Onboarding());
        } else {
          kPushAndRemoveUntil(context, page: Root());
        }

        break;
      case Status.error:
        HapticFeedback.mediumImpact();
        formKey.currentState!.validate();
        break;
      default:
    }
  }
}
