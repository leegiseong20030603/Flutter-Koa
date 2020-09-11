import'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:exmaple/HttpResponse.dart';
import 'package:exmaple/LeeChat/Config.dart';
import 'package:exmaple/LeeChat/Message.dart';
import 'package:exmaple/LeeChat/MessageList.dart';
import 'package:exmaple/User.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'MessageInput.dart';

class LeeChatPage extends StatefulWidget {
  @override
  _LeeChatPageState createState() => _LeeChatPageState();
}

class _LeeChatPageState extends State<LeeChatPage> {

  File file;
  String base64Image;
  Color _color;
  DateTime time;
  String now_time;
  User user = User.instance();
  final image_picker = ImagePicker();
  IOWebSocketChannel channel;
  Config config = Config();
  List<Message> messages = [];
  TextEditingController _message_Controller = TextEditingController();
  bool _icon;
  Icon icon;

  Future sendGalleryImage() async{
    final pick_image = await image_picker.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(pick_image.path);
      print("Choose File Type : " + file.statSync().type.toString());
      print("Choose File Size : " + file.statSync().size.toString());
      print("Choose File Mode : " + file.statSync().modeString());
    });
    String imageName = file.path.split("/").last; /// 이미지 이름
    if(file == null) return null; /// File Null값 예외처리
    String URL = config.URL+"test_file_upload.php"; /// 웹 URL PHP 파일 경로
    String PATH = config.PATH+"User\\"+user.id+"\\"; /// 서버 : 사용자 디렉토리 경로
    print("Server upload image Config URL : "+ URL);
    print("Server Image upload PATH : "+ PATH);
    File compressImage = await compressAndGetImage(file); /// 파일 압축
    var postUri = Uri.parse(URL);
    var request = http.MultipartRequest("POST", postUri);
    request.fields['name'] = imageName;
    request.fields['path'] = PATH;
    request.files.add(http.MultipartFile.fromBytes('file', await compressImage.readAsBytes(), contentType: MediaType('image', 'jpeg')));
    request.send().then((response) async {
      String a = await response.stream.bytesToString();
      print("########## 파일 업로드 결과 ########## \n${a}\n####################################");
    });
  }

  Future<File> compressAndGetImage(File image) async { /// 파일 압축 함수
    print("#### 파일 압축 시작 #####");
    var fileAsBytes = await image.readAsBytes();
    await image.delete();
    final compressImageBytes = await FlutterImageCompress.compressWithList(fileAsBytes);
    await image.writeAsBytes(compressImageBytes);
    print("Choose File Type : " + image.statSync().type.toString());
    print("Choose File Mode : " + image.statSync().modeString());
    print("Choose File Compress Size : "+image.statSync().size.toString());
    print("#### 파일 압축 종료 #####");
    return image;
  }

  Future start_camera() async {
    final image = await image_picker.getImage(source: ImageSource.camera);
    setState(() {
      file = File(image.path);
    });
  }

  @override
  void initState() {
    time = DateTime.now();
    icon = Icon(Icons.add);
    _icon = false;
    file = null;
    super.initState();
    soket_Connect();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  soket_Connect() async {
    channel = IOWebSocketChannel.connect(config.socket_conncet_URL);
    now_time = DateFormat('yyyy-MM-dd–kk:mm').format(time);
    Message message = Message(id: user.id, name: user.name, message: 'connect', time: now_time, image: user.image, direction: 0);
    var toJson = json.encode(message);
    channel.sink.add(toJson);
  }

  @override
  void deactivate() {
    super.deactivate();
    now_time = DateFormat('yyyy-MM-dd–kk:mm').format(time);
    Message message = Message(id: user.id, name: user.name, message: 'close', time: now_time, image: user.image, direction: 0);
    var toJson = json.encode(message);
    channel.sink.add(toJson);
    channel.sink.close();
  }
  void _sendMessage(){
    //final User user = Provider.of<User>(context);
    final _message = _message_Controller.value.text;
    now_time = DateFormat('yyyy-MM-dd–kk:mm').format(time);
    Message message = Message(id: user.id, name: user.name, message: _message, time: now_time, image: user.image, direction: 1);
    if(_message.isNotEmpty){
      var toJson = json.encode(message);
      messages.add(message);
      channel.sink.add(toJson);
      _message_Controller.clear();
    }
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.backspace, color: Colors.black,), onPressed: () {Navigator.pop(context);},), /// 뒤로가기 버튼
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list, color: Colors.black,), /// 채팅방 기능등
            onPressed: (){
              Scaffold(
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("테스트 1"),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 13,
            child: StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.data == null) {
                  return Center(
                    child: Text("메세지가 없습니다.\n먼저 메세지를 보내보세요!"),
                  );
                } else {
                  var message = snapshot.data;
                  print(message);
                  Message message_Item = Message.fromJson(json.decode(message));
                  if(message_Item.id != user.id){
                    messages.add(message_Item);
                  }
              //    Message messageItem = Message.fromJson(json.decode(message));
            //      print(messageItem);
                }
                return MessageList(
                  messages: messages,
                );
              },
            ),
          ),
          SizedBox(
              height: 50,
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
                                    sendGalleryImage();
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
