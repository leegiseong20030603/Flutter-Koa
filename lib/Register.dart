import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController id_Controller, pw_Controller, name_Controller, email_Controller, birthday_Controller;
  String id, pw, name, email, birthday, type, agree;
  @override
  void initState() {
    super.initState();
    id_Controller = TextEditingController();
    pw_Controller = TextEditingController();
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("회원가입",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,),),
                Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),),
                TextField(
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10),),
                TextField(
                  controller: pw_Controller,
                  maxLines: 1,
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10),),
                TextField(
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10),),
                TextField(
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10),),
                TextField(
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
                Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0),),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlueAccent, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                      Text("사용자 유형", style: TextStyle(fontSize: 20),),
                      CustomRadioButton(
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
                        },
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: Container(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text("회원가입"),
                      onPressed: () {
                        if(id_Controller.value.text.isEmpty){

                        }else if(pw_Controller.value.text.isEmpty){

                        }else if(name_Controller.value.text.isEmpty){

                        }else if(email_Controller.value.text.isEmpty){

                        }else if(birthday_Controller.value.text.isEmpty){

                        }else if(type.isEmpty){

                        }else if(agree.isEmpty){

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
          ),
        ),
      )
    );
  }
}
