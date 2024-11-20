import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  const CustomScaffold({super.key, this.appBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: PrimaryColors.white,
      body: Container(
        height: size(context: context).height,
        width: size(context: context).width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kAssetPath(imageName: 'gradient-main.jpg')))),
        child: body,
      ),
    );
  }
}
 