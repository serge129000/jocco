import 'package:flutter/material.dart';
import 'package:jocco/core/views/home/pages/message_components/message_list.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/path.dart';
import 'message_components/no_match.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, AppAuthProvider>(
      builder: (context, userProvider, appAuthProvider, _) {
        return Container(
          height: 1 / 0,
          width: 1 / 0,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Image.asset(
                      kIconAssetPath(imageName: 'jocco.png'),
                      height: 26.35,
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.center,
                  child: userProvider.chats.entries.isEmpty? NoMatch(): MessageList() /* NoMatch() */,
                ))
              ],
            ),
          ),
        );
      }
    );
  }
}
