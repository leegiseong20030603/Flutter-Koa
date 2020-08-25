import 'dart:convert';
import 'dart:io';

import 'package:exmaple/LeeChat/Config.dart';
import 'package:exmaple/LeeChat/Direction.dart';
import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/LeeChat/MessageInput.dart';
import 'package:exmaple/LeeChat/MessageList.dart';
import 'package:exmaple/User.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
class LeeChatPage extends StatefulWidget {
  @override
  _LeeChatPageState createState() => _LeeChatPageState();
}

class _LeeChatPageState extends State<LeeChatPage> {

  File _image;
  final image_picker = ImagePicker();
  IOWebSocketChannel channel;
  Config config = Config();
  List<Message> messages = [];
  TextEditingController _message_Controller = TextEditingController();
  bool _icon;
  Icon icon;

  Future gallery_getImage() async {
    final pick_File = await image_picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pick_File.path);
    });
  }

  Future start_camera() async {
    final pick_File = await image_picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pick_File.path);
    });
  }

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
    User user = User.instance();
    DateTime time = DateTime.now();
    String now_time = DateFormat('yyyy-MM-dd–kk:mm').format(time);
    Message messageItem = Message(id: user.id, name: user.name, message: message, time: now_time, image: user.image, direction: 2);
    if(message.isNotEmpty){
      channel.sink.add(messageItem);
      _message_Controller.clear();
      print(messageItem);
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
    List<CardItem> cardItem = [
      IconTitleCardItem(
        text: "갤러리",
        iconData: Icons.image,
      ),
      IconTitleCardItem(
        text: "카메라",
        iconData: Icons.camera_alt,
      ),
      IconTitleCardItem(
        text: "음성통화",
        iconData: Icons.add_call,
      ),
      IconTitleCardItem(
        text: "화상통화",
        iconData: Icons.video_call,
      ),
      IconTitleCardItem(
        text: "파일",
        iconData: Icons.attach_file,
      ),
      IconTitleCardItem(
        text: "공유",
        iconData: Icons.share
        ,
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.data == null || messages.length == 0) {
                  return Center(
                    child: Text("메세지가 없습니다.\n먼저 메세지를 보내보세요!"),
                  );
                } else {
                  var message = snapshot.data;
                  //    messages.add(message);
                  print(message);
                }
                return MessageList(
                  messages: messages,
                );
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
          _icon
              ? AnimatedContainer(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  duration: Duration(seconds: 2),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                            height: 80,
                            child: HorizontalCardPager(
                              initialPage: 3,
                              items: cardItem,
                              //              onPageChanged: (item) => print('$item'),
                              onSelectedItem: (item) {
                                switch(item){
                                  case 0:{
                                    gallery_getImage();
                                    break;
                                  }
                                  case 1:{
                                    start_camera();
                                    break;
                                  }
                                  case 2:{
                                    break;
                                  }
                                  case 3:{
                                    break;
                                  }
                                  case 4:{
                                    break;
                                  }
                                  case 5:{
                                    break;
                                  }
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  curve: Curves.fastOutSlowIn,
                )
              : Container(),
        ],
      ),
    ));
  }
}
