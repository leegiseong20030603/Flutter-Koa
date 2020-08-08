import 'package:connectivity/connectivity.dart';
import 'package:exmaple/MyPage.dart';
import 'package:exmaple/Select.dart';
import 'package:exmaple/Management.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Main_MenuPage extends StatefulWidget {
  @override
  _Main_MenuPageState createState() => _Main_MenuPageState();
}

class _Main_MenuPageState extends State<Main_MenuPage> {

  final key = GlobalKey<FormState>();

  var NetWorkState;

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
  void dispose() {
    super.dispose();
    NetWorkState.cancel();
  }

  @override
  void initState() {
    super.initState();
    NetWorkStatus();
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
          body: Form(
            key: key,
            child: TabBarView(
              children: <Widget>[
                SelectPage(),
                ManagementPage(),
                MyPage(),
              ],
            ),
          )
        ),
      ),
    );
  }
}
