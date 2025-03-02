import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/test_data.dart';
import 'package:jocco/core/views/widgets/message_card.dart';
import 'package:jocco/core/views/widgets/mini_user_circle_avatar.dart';
class MessageDetails extends StatefulWidget {
  const MessageDetails({super.key});

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( color: PrimaryColors.second, image: DecorationImage(image: AssetImage(kAssetPath(imageName: 'background_message.png')), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Container(
              height: 120,
              width: 1/0,
              decoration: BoxDecoration(
                color: appBarColor
              ),
              child: AppBar(
                iconTheme: IconThemeData(
                  color: PrimaryColors.white
                ),
                title: Row(
                  children: [
                    MiniUserCircleAvatar(url: userData['image']),
                    Padding(padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userData['nom'], style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: PrimaryColors.white,
                          fontWeight: FontWeight.bold
                        ),),
                         Text(userData['prenom'], style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: PrimaryColors.white,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),)
                  ],
                ),
              ),
            ),
            Flexible(child: ListView(
              children: [
                ...testChats.map((e)=> MessageCard(isReceived: true, message: e.message, dateTime: DateTime.fromMillisecondsSinceEpoch(e.time.millisecondsSinceEpoch)))
              ],
            )),
            Container(
              height: 114-25,
              width: 1/0,
              decoration: BoxDecoration(
                color: bottomBackground
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20
                ),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20
                    ),
                    child: TextFormField(
                      cursorColor: PrimaryColors.black,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: 15
                      ),
                      decoration: InputDecoration(
                         suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                
                              },
                              child: Image.asset(kIconAssetPath(imageName: 'send_pic.png'), height: 20, width: 20,)),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 10),
                              child: InkWell(
                                onTap: () {
                                  
                                },
                                child: Icon(Icons.add)),
                            )
                          ],
                         ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 15
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        fillColor: Color(0xffcef3f3)
                      ),
                    ),
                  )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
