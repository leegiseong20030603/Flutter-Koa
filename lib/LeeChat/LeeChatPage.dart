import 'dart:convert';

import 'package:exmaple/LeeChat/Config.dart';
import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/LeeChat/MessageInput.dart';
import 'package:exmaple/LeeChat/MessageList.dart';
import 'package:exmaple/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

class LeeChatPage extends StatefulWidget {
  @override
  _LeeChatPageState createState() => _LeeChatPageState();
}

class _LeeChatPageState extends State<LeeChatPage> {

  IOWebSocketChannel channel;
  Config config = Config();
  List<Message> messages = [];
  TextEditingController _message_Controller = TextEditingController();
  User user = User.instace;

  soket_Connect() async {
    channel = IOWebSocketChannel.connect(config.conncet_URL+config.port);
    channel.stream.listen((event) {
      channel.sink.add("connect");
    });
  }

  @override
  void initState() {
    super.initState();
    soket_Connect();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }
  void _sendMessage(){
    final User user = Provider.of<User>(context);

    final message = _message_Controller.value.text;
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd–kk:mm').format(time);
    print(time);
    //final Message messageitem = Message(id : Uuid().v1(), name : user.name, message : message, time : time, );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }
                  if(snapshot.data == null){
                    return Center(child: Text("메세지가 없습니다.\n먼저 메세지를 보내보세요!"),);
                  }else{
                    Message message = Message.fromJson(jsonDecode(snapshot.data));
                    if(messages.isEmpty){
                      messages.add(message);
                    }else{
                      if(message.id != messages.last.id){
                        messages.add(message);
                      }
                    }
                  }
                  return MessageList(messages: messages,);
                },
              ),
            ),
            Expanded(
              child: MessageInput(
                message_Controller: _message_Controller,
                onPressed: _sendMessage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
