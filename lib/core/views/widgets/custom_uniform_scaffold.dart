import 'package:flutter/material.dart';
import 'package:jocco/core/utils/screen.dart';

class CustomUniformScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigation;
  final bool? canResizeBottom;
  const CustomUniformScaffold(
      {super.key, this.appBar, this.body, this.bottomNavigation, this.canResizeBottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: canResizeBottom ?? false,
      extendBody: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigation,
      backgroundColor: Color(0xff006666),
      body: Container(
        height: size(context: context).height,
        width: size(context: context).width,
        decoration: const BoxDecoration(
            color: Color(0xff006666)
            /* image: DecorationImage(
                image: AssetImage(kAssetPath(imageName: 'gradient-main.jpg'))) */
            ),
        child: body,
      ),
    );
  }
}
