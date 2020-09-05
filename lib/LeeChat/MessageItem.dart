import 'package:exmaple/LeeChat/Direction.dart';
import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageItem extends StatelessWidget {

  final Message message;
  final Direction decoration = Direction();
  bool _bool, message_Type;
  MessageItem({@required this.message});

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    if(message.type == "message"){
      message_Type = true;
    }else{
      message_Type = false;
    }
    if(message.direction == decoration.RIGHT){
      alignment = Alignment.centerRight;
      _bool = true;
    }else if(message.direction == decoration.LEFT){
      alignment = Alignment.centerLeft;
      _bool = true;
    }else if(message.direction == decoration.CENTER){
      alignment = Alignment.center;
      _bool = false;
    }
    return Container(
      alignment: alignment,
      child: Column(
        children: <Widget>[
          _bool ? Text(message.name) : Container(child: null,),
          message_Type ? Chip(
            backgroundColor: Colors.white,
            label: Text(message.message),
            padding: EdgeInsets.all(4),
            avatar: _bool ? CircleAvatar(
              backgroundColor: Colors.white,
              radius: 100,
              backgroundImage: NetworkImage(message.image),
            ) : null,
          ) : Image.network(message.image),
        ],
      ),
    );
  }
}
