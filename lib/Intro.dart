import 'dart:async';
import 'dart:convert';

import 'package:exmaple/HttpResponse.dart';
import 'package:exmaple/Login.dart';
import 'package:exmaple/User.dart';
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
  HttpResponse httpResponse;
  User user;

  _Shared_User() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("User_ID") == null || sharedPreferences.getString("User_PW") == null){
      Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed("/LoginPage"));
    }else{
      User_ID = sharedPreferences.getString("User_ID");
      User_PW = sharedPreferences.getString("User_PW");
      print("###########Login###########" + "\n" + "User_ID : " + User_ID + "\n" + "User_PW : " + User_PW + "\n" + "###########################");
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
      httpResponse = HttpResponse.fromJson(json.decode(http_post.body));
      bool response_ = httpResponse.Response;
      print("response 값 : " + response_.toString());
      setState(() {
        if(response_){
          user = User(
              id : httpResponse.User_ID,
              pw : httpResponse.User_PW,
              name : httpResponse.User_Name,
              email: httpResponse.User_Email,
              birthday : httpResponse.User_Birthday,
              type : httpResponse.User_Type,
              image : httpResponse.User_Image,
              creation_date : httpResponse.User_Creation_Date,
              agree : httpResponse.User_Agree);
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
        child: Image(image: NetworkImage("http://leegiseong.kro.kr/phps/User_Images/basic_image.png"),)
      ),
    );
  }
}
