import 'dart:async';
import 'dart:convert';

import 'package:exmaple/HttpResponse.dart';
import 'package:exmaple/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  String URL = "http://leegiseong.kro.kr/phps/Login.php";
  String User_ID, User_PW;

  _Shared_User() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User_ID = User_ID == null ? "" : sharedPreferences.getString("User_ID");
    User_PW = User_PW == null ? "" : sharedPreferences.getString("User_PW");
    if(User_ID.isEmpty && User_PW.isEmpty){
      Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed("/LoginPage"));
    }else{
      print("###########################" + "\n" + "User_ID : " + User_ID + "\n" + "User_PW : " + User_PW + "\n" + "###########################");
      Map<String, String> Login_map = {
        "User_ID": User_ID,
        "User_PW": User_PW,
      };
      var http_post = await http.post(URL,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: Login_map,
          encoding: Encoding.getByName("utf-8"));

      print("####http_post.body : ${http_post.body}");
      HttpResponse httpResponse = HttpResponse.fromJson(json.decode(http_post.body));
      bool response_ = httpResponse.Response;
      print("response 값 : " + response_.toString());
      setState(() {
        if(response_){
          Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed("/Main_MenuPage"));
        }else{
          Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed("/LoginPage"));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _Shared_User();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loding....." ,style: TextStyle(fontSize: 60),),
      ),
    );
  }
}
