import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:exmaple/HttpResponse.dart';
import 'package:exmaple/Register.dart';
import 'package:exmaple/User.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();

  User user;
  TextEditingController ID_Controller, PW_Controller;
  var NetWorkState;

  String URL = "http://leegiseong.kro.kr/phps/Login.php";
  String User_ID, User_PW, User_Name, User_Email, User_Birthday, User_Type, User_Agree;
  Future<HttpResponse> Login() async {
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
      user = User(
          httpResponse.User_ID,
          httpResponse.User_PW,
          httpResponse.User_Name,
          httpResponse.User_Email,
          httpResponse.User_Birthday,
          httpResponse.User_Type,
          httpResponse.User_Image,
          httpResponse.User_Creation_Date,
          httpResponse.User_Agree);
      ID_Controller.clear();
      PW_Controller.clear();
      Navigator.of(context).pushReplacementNamed("/Main_MenuPage");
    }else{
      Toast.show("아이디 또는 비밀번호가 틀리거나\n아이디가 존재하지 않습니다.", context, gravity: Toast.CENTER);
    }
  }

  void NetWorkStatus() {
    setState(() {
      NetWorkState = Connectivity().onConnectivityChanged.listen((event) {
        if (event == ConnectivityResult.mobile || event == ConnectivityResult.wifi) {
          Flushbar(flushbarPosition: FlushbarPosition.TOP, message: "인터넷 연결", duration: Duration(seconds: 2),).show(key.currentContext);
        } else {
          Flushbar(flushbarPosition: FlushbarPosition.TOP, message: "인터넷 끊김", duration: Duration(seconds: 2),).show(key.currentContext);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ID_Controller = TextEditingController();
    PW_Controller = TextEditingController();
    NetWorkStatus();
  }

  @override
  void dispose() {
    super.dispose();
    ID_Controller.dispose();
    PW_Controller.dispose();
    NetWorkState.cancel();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("앱을 종료하시곘습니까??"),
        actions: <Widget>[
          FlatButton(
            child: Text("넵"),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            child: Text("아니욥"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: Form(
            key: key,
            child: Center(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("로그인", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 25),),
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
                                keyboardType: TextInputType.visiblePassword,
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
                              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.lightBlueAccent, width: 2),
                                  ),
                                  child: RaisedButton(
                                    color: Colors.white,
                                    child: Text("로그인"),
                                    onPressed: () {
                                      if(ID_Controller.value.text.isEmpty){
                                        Toast.show("아이디를 넣어주세요.",context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                      }else if(PW_Controller.value.text.isEmpty){
                                        Toast.show("비밀번호를 넣어주세요.",context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                      }else if(PW_Controller.value.text.length < 5){
                                        Toast.show("비밀번호를 6자이상 넣어주세요.",context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                      }else{
                                        User_ID = ID_Controller.value.text;
                                        User_PW = PW_Controller.value.text;
                                        Login();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 10),),
                              SizedBox(
                                height: 25,
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 1,
                                      width: 110,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 6, 0),),
                                    Text("or"),
                                    Padding(padding: EdgeInsets.fromLTRB(6, 0, 0, 0),),
                                    SizedBox(
                                      height: 1,
                                      width: 110,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5),),
                              SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.lightBlueAccent, width: 2)
                                    ),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => RegisterPage(),
                                        ));
                                      },
                                      child: Text("회원가입"),
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                )
            ),
          )
      )
    );
  }
}
