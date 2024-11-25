import 'package:flutter/material.dart';
import 'package:jocco/core/views/widgets/button.dart';

import '../../utils/all_text.dart';
import '../../utils/color.dart';
import '../../utils/path.dart';
import '../../utils/screen.dart';
import '../auth/register.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
                            isTransparent: true,
                            function: () {
                              kPushToPage(context, page: const RegisterScreen());
                            },
                            child: Text(
                              AllText.openAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: PrimaryColors.white, fontWeight: FontWeight.w600),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Btn(
                            isTransparent: false,
                            function: () {},
                            child: Text(
                              AllText.logIn,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: PrimaryColors.first, fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
