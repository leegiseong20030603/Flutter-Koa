import 'package:exmaple/LeeChat/Direction.dart';
import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageItem extends StatelessWidget {

  final Message message;
  final Direction decoration = Direction();
  MessageItem({@required this.message});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    Alignment alignment;
    if(message.direction == decoration.RIGHT){
      alignment = Alignment.topRight;
    }else if(message.direction == decoration.LEFT){
      alignment = Alignment.topLeft;
    }else if(message.direction == decoration.CENTER){
      alignment = Alignment.topCenter;
    }
    return Align(
      alignment: alignment,
      child: Chip(
        label: Text(message.message),
        avatar: CircleAvatar(
          backgroundImage: NetworkImage(user.image),
        ),
      ),
    );
  }
}
