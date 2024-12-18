// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/root.dart';
import 'package:jocco/core/views/landing/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((v) {
      HapticFeedback.mediumImpact();
      if (FirebaseAuth.instance.currentUser == null) {
        kReplaceToPage(context, page: const LandingScreen());
      } else {
        kReplaceToPage(context, page: const Root());
      }
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
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: Image.asset(kAssetPath(imageName: 'log1.png'),
            fit: BoxFit.cover,
                height: 280, width: 277.11)),
      ),
    );
  }
}
