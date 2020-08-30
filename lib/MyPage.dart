import 'package:exmaple/User.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlueAccent, width: 2),
                  ),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text("로그아웃"),
                    onPressed: () async {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.remove("User_ID");
                      sharedPreferences.remove("User_PW");
                      User.Reset();
                      Navigator.of(context).pushReplacementNamed("/LoginPage");
                    },
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
