import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("로그아웃"),
                onPressed: () async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.remove("User_ID");
                  sharedPreferences.remove("User_PW");
                  Navigator.of(context).pushReplacementNamed("/LoginPage");
                },
              )
            ],
          ),
      ),
    );
  }
}
