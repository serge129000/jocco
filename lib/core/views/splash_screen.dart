// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/root.dart';
import 'package:jocco/core/views/landing/landing_screen.dart';
import 'package:jocco/core/views/onboarding/onboarding.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppAuthProvider authProvider;
  late StepProvider stepProvider;
  @override
  void initState() {
    authProvider = context.read<AppAuthProvider>();
    stepProvider = context.read<StepProvider>();
    authProvider.init();
    Future.delayed(const Duration(seconds: 2)).then((v) async {
      stepProvider.reinitAll();
      HapticFeedback.mediumImpact();
      if (FirebaseAuth.instance.currentUser == null) {
        kReplaceToPage(context, page: const LandingScreen());
      } else {
        await authProvider.me();
        if (authProvider.currentAppUser!.projet == null) {
          kPushAndRemoveUntil(context, page: Onboarding());
        } else {
          kPushAndRemoveUntil(context, page: const Root());
        }
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
                fit: BoxFit.cover, height: 280, width: 277.11)),
      ),
    );
  }
}
