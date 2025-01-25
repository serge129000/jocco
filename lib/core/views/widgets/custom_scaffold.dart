import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigation;
  final bool? canResizeBottom;
  const CustomScaffold(
      {super.key, this.appBar, this.body, this.bottomNavigation, this.canResizeBottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: canResizeBottom ?? false,
      extendBody: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigation,
      backgroundColor: PrimaryColors.white,
      body: Container(
        height: size(context: context).height,
        width: size(context: context).width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Color(0xff00CCCC), Color(0xff006666)])
            /* image: DecorationImage(
                image: AssetImage(kAssetPath(imageName: 'gradient-main.jpg'))) */
            ),
        child: body,
      ),
    );
  }
}
