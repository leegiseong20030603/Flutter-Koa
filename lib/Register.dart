import 'dart:convert';
import 'dart:math';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:exmaple/HttpResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final key = GlobalKey<FormState>();
  FocusNode id_Focus;
  TextEditingController id_Controller, pw_Controller, pw_Check_Controller, name_Controller, email_Controller, birthday_Controller;
  String id, pw, name, email, birthday, type, agree, agree_1, agree_2, URL;
  bool bool_agree_1, bool_agree_2, all_agree;

  Future<HttpResponse> Register() async{
    Map<String, String> Register_Map = {
      'User_ID' : id,
      'User_PW' : pw,
      'User_Name' : name,
      'User_Email' : email,
      'User_Birthday' : birthday,
      'User_Type' : type,
      'User_Agree' : agree,
    };
    var http_post = await http.post(
      URL,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: Register_Map,
      encoding: Encoding.getByName("utf-8"),);
    final response = HttpResponse.fromJson(json.decode(http_post.body));
    if(response.Response){
      Scaffold.of(key.currentContext).showSnackBar(SnackBar(
        action: SnackBarAction(
          onPressed: () {
            Navigator.of(key.currentContext).pop();
          },
          label: "완료",
        ),
        content: Text("회원가입에 성공하셨습니다."),
      ));
    }else{
      Toast.show("이미 등록되어있는 아이디입니다.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      FocusScope.of(key.currentContext).requestFocus(id_Focus);
    }
  }

  @override
  void initState() {
    super.initState();
    URL = "http://leegiseong.kro.kr/phps/Register.php";
    agree = "";
    agree_1 = "";
    agree_2 = "";
    bool_agree_1 = false;
    bool_agree_2 = false;
    all_agree = false;

    id_Focus = FocusNode();

    id_Controller = TextEditingController();
    pw_Controller = TextEditingController();
    pw_Check_Controller = TextEditingController();
    name_Controller = TextEditingController();
    email_Controller = TextEditingController();
    birthday_Controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    id_Controller.dispose();
    pw_Controller.dispose();
    name_Controller.dispose();
    email_Controller.dispose();
    birthday_Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Center(
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: <Widget>[
                    Text("회원가입",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent, width: 2),
                        //    borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                          Text("사용자 유형", style: TextStyle(fontSize: 20),),
                          CustomRadioButton( /// Choice User Type
                            horizontal: true,
                            width: 150,
                            defaultSelected: "normal",
                            enableButtonWrap: false,
                            unSelectedColor: Theme.of(context).canvasColor,
                            selectedColor: Theme.of(context).accentColor,
                            buttonLables: [
                              "일반사용자",
                              "학생",
                              "학부모",
                              "선생님",
                            ],
                            buttonValues: [
                              "normal",
                              "student",
                              "parent",
                              "teacher",
                            ],
                            buttonTextStyle: ButtonTextStyle(
                              selectedColor: Colors.white,
                              unSelectedColor: Colors.black,
                              textStyle: TextStyle(fontSize: 16),
                            ),
                            radioButtonValue: (value) {
                              type = value;
                              print(type);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    TextField( /// ID TextField
                      focusNode: id_Focus,
                      controller: id_Controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: "아이디",
                        hintText: "아이디",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    TextField( /// Password TextField
                      obscureText: true, // 안보이는 비밀번호
                      controller: pw_Controller,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "비밀번호",
                        hintText: "비밀번호",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    TextField( /// Password Check TextField
                      obscureText: true, // 안보이는 비밀번호
                      controller: pw_Check_Controller,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "비밀번호 확인",
                        hintText: "비밀번호 확인",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    TextField( /// Name TextField
                      controller: name_Controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: "이름",
                        hintText: "이름",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    TextField( /// Email TextField
                      keyboardType: TextInputType.emailAddress,
                      controller: email_Controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: "이메일",
                        hintText: "이메일",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    TextField( /// Birthday TextField
                      controller: birthday_Controller,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 8,
                      decoration: InputDecoration(
                        labelText: "생년월일",
                        helperText: "생년월일 8자리 예) 19880527",
                        hintText: "생년월일",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                                width: 2
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    SizedBox(
                      width: 260,
                      height: 50,
                      child: CheckboxListTile(
                        value: bool_agree_1,
                        title: Text("개인정보 수집 동의"),
                        activeColor: Colors.lightBlueAccent,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            bool_agree_1 = value;
                            agree_1 = bool_agree_1 == false ? "" : "개인정보 수집 동의\n";
                            print(bool_agree_1);
                            print(agree_1);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 260,
                      child: CheckboxListTile(
                        value: bool_agree_2,
                        title: Text("사용자 정보 마케팅 동의"),
                        activeColor: Colors.lightBlueAccent,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            bool_agree_2 = value;
                            agree_2 = bool_agree_2 == false ? "" : "사용자 정보 마케팅 동의";
                            print(agree_2);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 260,
                      child: CheckboxListTile(
                        value: all_agree,
                        title: Text("모두 동의"),
                        activeColor: Colors.lightBlueAccent,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            bool_agree_1 = value;
                            bool_agree_2 = value;
                            all_agree = value;
                            agree_1 = bool_agree_1 == false ? "" : "개인정보 수집 동의\n";
                            agree_2 = bool_agree_2 == false ? "" : "사용자 정보 마케팅 동의";
                            print(agree_1);
                          });
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    SizedBox(
                      width: 300,
                      height: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2)
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                    SizedBox( /// Register RaisedButton
                      height: 50,
                      width: 300,
                      child: Container(
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text("회원가입"),
                          onPressed: () {
                            if(id_Controller.value.text.isEmpty){
                              Toast.show("아이디를 넣어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(pw_Controller.value.text.isEmpty){
                              Toast.show("비밀번호를 넣어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(pw_Check_Controller.value.text.isEmpty) {
                              Toast.show("비밀번호 확인을 넣어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(name_Controller.value.text.isEmpty){
                              Toast.show("이름을 넣어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(email_Controller.value.text.isEmpty){
                              Toast.show("이메일을 넣어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(birthday_Controller.value.text.isEmpty){
                              Toast.show("생년원일을 넣어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(!bool_agree_1){
                              Toast.show("개인정보 수집동의를 체크해주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(pw_Controller.value.text.length < 6){
                              Toast.show("비밀번호를 6자리 이상으로해주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if (identical(pw_Controller.value.text, pw_Check_Controller.value.text)) {
                              Toast.show("비밀번호와 비밀번호 확인이 일치하지 않습니다.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(email_Controller.value.text)) {
                              Toast.show("이메일 형식을 맞추어주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else if(birthday_Controller.value.text.length < 8){
                              Toast.show("생년월일 8자리를 입력해주세요.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }else{
                              id = id_Controller.value.text;
                              pw = pw_Check_Controller.value.text;
                              name = name_Controller.value.text;
                              email = email_Controller.value.text;
                              birthday = birthday_Controller.value.text;
                              if(agree_2.isEmpty){
                                agree += agree_1;
                              }else{
                                agree = agree_1 + agree_2;
                              }
                              print("ID : " + id + "\n" +
                                  "PW : " + pw + "\n" +
                                  "Name : " + name + "\n" +
                                  "Email : " + email + "\n" +
                                  "Birthday : " + birthday + "\n" +
                                  "Type : " + type + "\n" +
                                  "Agree : " + agree + "\n");
                              Register();
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent, width: 2),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
