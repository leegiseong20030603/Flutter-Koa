import 'dart:convert';

import 'package:exmaple/HttpResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String URL = "http://leegiseong.kro.kr/phps/Login.php";
  String User_ID, User_PW, User_Name, User_Email, User_Birthday, User_Type, User_Agree;

  Future<HttpResponse> httpResponse() async{
    Map<String,String> Login_map = {
      "User_ID" : User_ID,
      "User_PW" : User_PW,
    };
    var http_post = await http.post(
        URL,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: Login_map,
        encoding: Encoding.getByName("utf-8"));

    HttpResponse httpResponse = json.decode(http_post.body);
    bool response = httpResponse.Response;
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("로그인", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
              TextFormField(
                validator: User_ID_validator,
                decoration: InputDecoration(
                  hintText: "아이디",
                  labelText: "아이디",
                ),
              ),
              TextFormField(
                validator: User_PW_validator,
                decoration: InputDecoration(
                  hintText: "비밀번호",
                  labelText: "비밀번호",
                ),
              ),
              RaisedButton(
                child: Text("로그인"),
                onPressed: () {
                  httpResponse();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String User_ID_validator(String value) {
    if(value.isEmpty){
      return "아이디를 넣어주세요.";
    }else{
      User_ID = value;
    }
  }

  String User_PW_validator(String value) {
    if(value.isEmpty){
      return "비밀번호를 넣어주세요.";
    }else{
      User_PW = value;
    }
  }
}
