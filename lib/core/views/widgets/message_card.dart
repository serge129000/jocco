import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  final bool isReceived;
  final String message;
  final DateTime dateTime;
  const MessageCard(
      {super.key,
      required this.isReceived,
      required this.message,
      required this.dateTime});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isReceived ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: widget.isReceived
            ? const EdgeInsets.only(top: 5.0, left: 10.0, right: 90)
            : const EdgeInsets.only(top: 5.0, left: 90.0, right: 10),
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: 20,
                    left: 20),
                decoration: BoxDecoration(
                  color: widget.isReceived ? Color(0xffC5FCFC
) : Color(0xfff6f7f7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft:
                        widget.isReceived ? Radius.zero : Radius.circular(12.0),
                    bottomRight:
                        widget.isReceived ? Radius.circular(12.0) : Radius.zero,
                  ),
                ),
                child: Text(
                  widget.message,
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            /* Positioned(
                bottom: 5,
                right: !isReceived? 5: null,
                left: !isReceived? null : 5,
                child: Text(
                  DateFormat('HH:mm').format(dateTime),
                  style: Theme.of(context).textTheme.labelSmall,
                )) */
          ],
        ),
      ),
    );
  }
}
