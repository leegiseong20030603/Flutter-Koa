import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/LeeChat/MessageItem.dart';
import 'package:flutter/cupertino.dart';

class MessageList extends StatelessWidget {

  final List<Message> messages;

  MessageList({this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) => MessageItem(message: messages[index],)
    );
  }
}
