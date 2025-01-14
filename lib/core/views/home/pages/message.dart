import 'package:flutter/material.dart';
import 'package:jocco/core/views/home/pages/message_components/no_match.dart';

import '../../../utils/path.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1 / 0,
      width: 1 / 0,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Image.asset(
                kIconAssetPath(imageName: 'jocco.png'),
                height: 26.35,
              ),
            ),
            Expanded(child: Align(
              alignment: Alignment.center,
              child: NoMatch(),
            ))
          ],
        ),
      ),
    );
  }
}