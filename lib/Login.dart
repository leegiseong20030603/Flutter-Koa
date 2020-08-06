import 'dart:convert';
import 'dart:developer' as log;

import 'package:exmaple/HttpResponse.dart';
import 'package:exmaple/Main_Menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController ID_Controller, PW_Controller;

  String URL = "http://leegiseong.kro.kr/phps/Login.php";
  String User_ID, User_PW, User_Name, User_Email, User_Birthday, User_Type, User_Agree;
  Future<HttpResponse> httpResponse() async {
    Map<String, String> Login_map = {
      "User_ID": User_ID,
      "User_PW": User_PW,
    };
    print("######아이디 : " + '$User_ID' + "비밀번호 : "+ '$User_PW');
    var http_post = await http.post(
        URL,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: Login_map,
        encoding: Encoding.getByName("utf-8"));
    print("####http_post.body : ${http_post.body}");
    final httpResponse = HttpResponse.fromJson(json.decode(http_post.body));
    if(httpResponse.Response){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("User_ID", ID_Controller.value.text);
      sharedPreferences.setString("User_PW", PW_Controller.value.text);
      print(sharedPreferences.getString("User_ID") + "\n" + sharedPreferences.getString("User_PW"));
      ID_Controller.clear();
      PW_Controller.clear();
      Navigator.of(context).pushReplacementNamed("/Main_MenuPage");
    }else{
      Toast.show("아이디 또는 비밀번호가 틀립니다.", context, gravity: Toast.TOP);
    }
  }

  @override
  void initState() {
    super.initState();
    ID_Controller = TextEditingController();
    PW_Controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    ID_Controller.dispose();
    PW_Controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("로그인", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 30),),
                TextFormField(
                  controller: ID_Controller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                    ),
                    hintText: "아이디",
                    labelText: "아이디",
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                TextField(
                  controller: PW_Controller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                    ),
                    hintText: "비밀번호",
                    labelText: "비밀번호",
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),),
                RaisedButton(
                  child: Text("로그인"),
                  onPressed: () {
                    if(ID_Controller.value.text.isEmpty){
                      Toast.show("아이디를 넣어주세요.",context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                    }else if(PW_Controller.value.text.isEmpty){
                      Toast.show("비밀번호를 넣어주세요.",context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                    }else if(PW_Controller.value.text.length < 5){
                      Toast.show("비밀번호를 6자이상 넣어주세요.",context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                    }else{
                      User_ID = ID_Controller.value.text;
                      User_PW = PW_Controller.value.text;
                      httpResponse();
                    }
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
