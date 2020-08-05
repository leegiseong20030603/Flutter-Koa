import 'package:exmaple/MyPage.dart';
import 'package:exmaple/Select.dart';
import 'package:exmaple/Management.dart';
import 'package:flutter/material.dart';

class Main_MenuPage extends StatefulWidget {
  @override
  _Main_MenuPageState createState() => _Main_MenuPageState();
}

class _Main_MenuPageState extends State<Main_MenuPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              SelectPage(),
              ManagementPage(),
              MyPage(),
            ],
          ),
        ),
      ),
    );
  }
}
