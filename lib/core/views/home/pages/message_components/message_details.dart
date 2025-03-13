import 'package:flutter/material.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/message_card.dart';
import 'package:jocco/core/views/widgets/mini_user_circle_avatar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MessageDetails extends StatefulWidget {
  final String? roomId;
  final AppUser? destinataire;
  const MessageDetails({super.key, this.roomId, this.destinataire});

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, AppAuthProvider>(
        builder: (context, userProvider, appAuthProvider, _) {
      final destinataireList = userProvider.rooms.entries
          .where((e) => e.key == widget.roomId)
          .firstOrNull;
      final destinataire = destinataireList?.value
              .where((e) => e.id != appAuthProvider.currentAppUser?.id)
              .firstOrNull ??
          widget.destinataire;
      final currentUser = appAuthProvider.currentAppUser!;
      return Container(
        decoration: BoxDecoration(
            color: PrimaryColors.second,
            image: DecorationImage(
                image:
                    AssetImage(kAssetPath(imageName: 'background_message.png')),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: bottomBackground,
            iconTheme: IconThemeData(color: PrimaryColors.white),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MiniUserCircleAvatar(
                  url: destinataire?.profileImage ?? '',
                  customSize: 45,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destinataire?.prenom ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: PrimaryColors.white,
                                fontWeight: FontWeight.bold),
                      ),
                      Text(
                        destinataire?.projet?.description ?? '',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: PrimaryColors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Flexible(child: Builder(builder: (context) {
                final chatsSorted = sortMessagesByDate(
                        (userProvider.chats[widget.roomId ?? '']) ?? [])
                    .entries
                    .toList();
                return ListView.builder(
                  controller: scrollController,
                  itemCount: chatsSorted.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: bottomBackground,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              showDay(chatsSorted[index].key),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: PrimaryColors.white),
                            ),
                          ),
                        ),
                        ...chatsSorted[index].value.map((e) => MessageCard(
                            isReceived: e.sender != currentUser.id,
                            message: e.message,
                            dateTime: e.time.toDate().toLocal()))
                      ],
                    );
                  },
                );
              })),
              Container(
                height: 114 - 25,
                width: 1 / 0,
                decoration: BoxDecoration(color: bottomBackground),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: messageController,
                          textInputAction: TextInputAction.send,
                          cursorColor: PrimaryColors.black,
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              userProvider.sendMessage(
                                uuid: Uuid().v4(),
                                  text: value,
                                  senderId: currentUser.id,
                                  currentUser: currentUser,
                                  secondUser: destinataire!);
                              messageController.text = '';
                              setState(() {});
                            }
                          },
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 15),
                          decoration: InputDecoration(
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        kIconAssetPath(
                                            imageName: 'send_pic.png'),
                                        height: 20,
                                        width: 20,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: InkWell(
                                        onTap: () {}, child: Icon(Icons.add)),
                                  )
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              filled: true,
                              hintText: AllText.writeMessage,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              fillColor: Color(0xffcef3f3)),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
