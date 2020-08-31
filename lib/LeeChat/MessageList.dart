import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/LeeChat/MessageItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final List<Message> messages;
  MessageList({this.messages});
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.messages.length,
        itemBuilder: (context, index){
          final item = widget.messages[index];
          return Dismissible(
            key: Key(item.message),
            onDismissed: (value) {
              setState(() {
                print(index);
                widget.messages.removeAt(index);
                print(widget.messages.length);
              });
            },
            child: MessageItem(message: item,),
          );
        }
    );
  }
}

