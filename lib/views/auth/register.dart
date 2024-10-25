import 'package:flutter/material.dart';
import 'package:jocco/views/auth/phone_register_sign_in.dart';
import 'package:jocco/views/widgets/button.dart';

import '../../core/utils/all_text.dart';
import '../../core/utils/color.dart';
import '../../core/utils/path.dart';
import '../../core/utils/screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context: context).height,
      width: size(context: context).width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [PrimaryColors.gradientF, PrimaryColors.first],
              stops: [0.0, 0.765])),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kAssetPath(imageName: 'Layer_1.png')))),
        child: Column(
          children: [
            SizedBox(
              height: size(context: context).height / 3,
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Image.asset(kIconAssetPath(imageName: 'logo.png'),
                    height: 136.59, width: 140)),
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Btn(
                            isTransparent: false,
                            function: () {
                              kPushToPage(context, page: const PhoneRegisterSignIn());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  kIconAssetPath(imageName: 'phone.png'),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    AllText.registerPhone,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: PrimaryColors.first,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Btn(
                            isTransparent: false,
                            function: () {
                              //print(2);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  kIconAssetPath(imageName: 'apple.png'),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    AllText.registerApple,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: PrimaryColors.first,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Btn(
                            isTransparent: false,
                            function: () {
                              //print(2);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  kIconAssetPath(imageName: 'fb.png'),
                                  height: 24,
                                  width: 24,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    AllText.registerFb,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: PrimaryColors.first,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
