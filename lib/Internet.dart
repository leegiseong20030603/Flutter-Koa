import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetWorkStatus extends StatefulWidget {
  @override
  _NetWorkStatusState createState() => _NetWorkStatusState();
}

class _NetWorkStatusState extends State<NetWorkStatus> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
        if (result.data == ConnectivityResult.mobile || result.data == ConnectivityResult.wifi) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("인터넷 연결"),duration: Duration(seconds: 2),));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("인터넷 끊김"),duration: Duration(seconds: 2),));
        }
      },
    );
  }
}

