import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/utils/test_data.dart';
import 'package:jocco/core/views/home/pages/message_components/message_details.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/mini_user_circle_avatar.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return ListView.builder(
        itemCount: userProvider.chats.entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              kPushToPage(context, page: MessageDetails());
            },
            leading: MiniUserCircleAvatar(url: userData['image']),
            title: Text(
              userData['nom'],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: PrimaryColors.white),
            ),
            subtitle: Text(
              'Comment ca va?',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: PrimaryColors.white),
            ),
            trailing: Text(
              '00:00',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: PrimaryColors.white,
                  fontSize: 12),
            ),
          );
        },
      );
    });
  }
}
