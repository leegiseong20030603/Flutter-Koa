import 'dart:convert';

import 'package:exmaple/LeeChat/Config.dart';
import 'package:exmaple/LeeChat/Direction.dart';
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
  bool _icon;
  Icon icon;

 // User user = User.instace;

  soket_Connect() async {
    channel = IOWebSocketChannel.connect(config.socket_conncet_URL);
    channel.sink.add('연결');
  }

  @override
  void initState() {
    icon = Icon(Icons.add);
    _icon = false;
    super.initState();
    soket_Connect();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  @override
  void deactivate() {
    super.deactivate();
    channel.sink.add("나감");
    channel.sink.close();
  }
  void _sendMessage(){
    //final User user = Provider.of<User>(context);
    final message = _message_Controller.value.text;
    if(message.isNotEmpty){
      channel.sink.add(message);
      _message_Controller.clear();
    }
 //   messages.add(message);
//    DateTime time = DateTime.now();
//    String formattedDate = DateFormat('yyyy-MM-dd–kk:mm').format(time);
//    print(time);
    //final Message messageitem = Message(id : Uuid().v1(), name : user.name, message : message, time : time, );
  }

  void _plus_optcion(){
    if(_icon == false){
      setState(() {
        icon = Icon(Icons.close);
        _icon = true;
        print(_icon);
      });
    }else{
      setState(() {
        icon = Icon(Icons.add);
        _icon = false;
        print(_icon);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }
                  if(snapshot.data == null){
                    return Center(child: Text("메세지가 없습니다.\n먼저 메세지를 보내보세요!"),);
                  }else{
                    var message = snapshot.data;
                //    messages.add(message);
                    print(message);
                  }
                  return MessageList(messages: messages,);
                },
              ),
            ),
            Expanded(
              child: MessageInput(
                message_Controller: _message_Controller,
                Message_send_onPressed: _sendMessage,
                plus_onPressed: _plus_optcion,
                icon: icon,
              ),
            ),
            _icon ? AnimatedContainer(
              duration: Duration(seconds: 2),
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.image), onPressed: () {},),
                          IconButton(icon: Icon(Icons.video_library), onPressed: () {},),
                          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {},),
                          IconButton(icon: Icon(Icons.videocam), onPressed: () {},),
                          IconButton(icon: Icon(Icons.attach_file), onPressed: () {},),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.share), onPressed: () {},),
                          IconButton(icon: Icon(Icons.group), onPressed: () {},),
                          IconButton(icon: Icon(Icons.add_call), onPressed: () {},),
                          IconButton(icon: Icon(Icons.video_call), onPressed: () {},),
                          IconButton(icon: Icon(Icons.pageview), onPressed: () {},),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              curve: Curves.fastOutSlowIn,
            ): Container(),
          ],
        ),
      ),
    );
  }
}
