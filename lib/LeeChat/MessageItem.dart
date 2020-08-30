import 'package:exmaple/LeeChat/Direction.dart';
import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageItem extends StatelessWidget {

  final Message message;
  final Direction decoration = Direction();
  bool _bool;
  MessageItem({@required this.message});

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    if(message.direction == decoration.RIGHT){
      alignment = Alignment.topRight;
      _bool = true;
    }else if(message.direction == decoration.LEFT){
      alignment = Alignment.topLeft;
      _bool = true;
    }else if(message.direction == decoration.CENTER){
      alignment = Alignment.topCenter;
      _bool = false;
    }
    return Align(
      alignment: alignment,
      child: Chip(
        backgroundColor: Colors.white,
        label: Text(message.message),
        padding: EdgeInsets.all(4),
        avatar: _bool ? CircleAvatar(
          backgroundColor: Colors.white,
          radius: 100,
          backgroundImage: NetworkImage(message.image),
        ) : Container(),
      ),
    );
  }
}
