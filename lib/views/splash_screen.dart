// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/views/landing/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((v){
      kReplaceToPage(context, page: const LandingScreen());
    });
    super.initState();
  }

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
                child: Text(
                  AllText.splashText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: PrimaryColors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
