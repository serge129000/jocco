import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/date_t.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/pages/message_components/message_details.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/mini_user_circle_avatar.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, AppAuthProvider>(
        builder: (context, userProvider, appAuthProvider, _) {
      final entries = sortUserChatsByLastMessage(userProvider.chats.entries.toList()).where((e)=> e.value.isNotEmpty).toList();
      //print(entries);
      return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final currentRoomId = entries[index].key;
          final destinataireList = userProvider.rooms.entries
              .where((e) => e.key == currentRoomId)
              .single;
          final destinataire = destinataireList.value
              .where((e) => e.id != appAuthProvider.currentAppUser?.id).firstOrNull;
          final lastChat = entries[index].value.lastOrNull;
          return Builder(builder: (context) {
            return ListTile(
              onTap: () {
                kPushToPage(context, page: MessageDetails(roomId: currentRoomId,));
              },
              leading: MiniUserCircleAvatar(url: destinataire?.profileImage ?? '',),
              title: Text(
                destinataire?.prenom ?? '',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: PrimaryColors.white),
              ),
              subtitle: Text(
               lastChat?.message ?? '',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w500, color: PrimaryColors.white),
              ),
              trailing: Builder(
                builder: (context) {
                  final bld = lastChat?.time.toDate().toLocal() ?? DateTime.now();
                  final now = DateTime.now();
                  return Text(
                    bld.day == now.day && bld.year == now.year? DateFormat('HH:mm').format(bld): DateT.getDureeRelative(bld),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: PrimaryColors.white,
                        fontSize: 12),
                  );
                }
              ),
            );
          });
        },
      );
    });
  }
}
