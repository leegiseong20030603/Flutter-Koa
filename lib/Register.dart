import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var id_Controller, pw_Controller, name_Controller, email_Controller, birthday_Controller, type_Controller, agree_Controller;
  String id, pw, name, email, birthday, type, agree;
  @override
  void initState() {
    super.initState();
    id_Controller = TextEditingController();
    pw_Controller = TextEditingController();
    name_Controller = TextEditingController();
    email_Controller = TextEditingController();
    birthday_Controller = TextEditingController();
    type_Controller = TextEditingController();
    agree_Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(50),
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
                TextField(
                  controller: id_Controller,
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
                TextField(
                  controller: id_Controller,
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
                TextField(
                  controller: id_Controller,
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
                TextField(
                  controller: id_Controller,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: "생년월일",
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15),),
              ],
            ),
          ),
        ),
      )
    );
  }
}
