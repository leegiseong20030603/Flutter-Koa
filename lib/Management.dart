import 'package:exmaple/LeeChat/LeeChatPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Management",
                style: TextStyle(fontSize: 50),
              ),
              RaisedButton(
                child: Text("LeeChat"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LeeChatPage()));
                  },
              ),
              RaisedButton(
                child: Text("현재 시간"),
                onPressed: () {
                  DateTime time = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd–kk:mm').format(time);
                  print(formattedDate);
                },
              )
        ],
      )),
    );
  }
}
