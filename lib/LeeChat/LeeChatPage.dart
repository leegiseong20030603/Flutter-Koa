import 'package:exmaple/LeeChat/Config.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class LeeChatPage extends StatefulWidget {
  @override
  _LeeChatPageState createState() => _LeeChatPageState();
}

class _LeeChatPageState extends State<LeeChatPage> {

  IOWebSocketChannel channel;
  Config config = Config();

  soket_Connect() async {
    channel = IOWebSocketChannel.connect(config.conncet_URL+config.port);
    channel.stream.listen((event) {
      channel.sink.add("add");

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
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
