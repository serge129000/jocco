import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String message;
  final ChatStatus chatStatus;
  final Timestamp time;
  final String sender;
  Chat(
      {required this.message,
      required this.time,
      required this.chatStatus,
      required this.sender});
  factory Chat.fromjson(_) {
    return Chat(
        message: _['text'],
        time: _['timestamp'] ?? Timestamp.now(),
        chatStatus: ChatStatus.fromString(_['status']),
        sender: _['sender']);
  }
}

enum ChatStatus {
  read(value: 'read'),
  unread(value: 'unRead');

  final String value;
  const ChatStatus({required this.value});
  factory ChatStatus.fromString(_) =>
      ChatStatus.values.where((e) => e.value == _).single;
}
