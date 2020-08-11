import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {

  final TextEditingController message_Controller;
  final Function onPressed;

  MessageInput({@required this.message_Controller, this.onPressed});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: TextField(
              controller: widget.message_Controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                hintText: "메세지를 입력하세요...."
              ),
            ),
          ),
          Flexible(
            child: IconButton(
              color: Colors.lightBlueAccent,
              onPressed: widget.onPressed,
              icon: Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
