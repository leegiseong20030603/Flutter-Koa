import 'dart:js';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Internet_Status extends StatelessWidget {

  String netWork_Status = "";

  initConnect() async {
    ConnectivityResult connectResult;
    connectResult = await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if(snapshot.hasData){
          if(snapshot.data == ConnectivityResult.wifi || snapshot.data == ConnectivityResult.mobile){

          }else{
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("인터넷 끊김"),duration: Duration(seconds: 4),));
          }
        }else{

        }
      },);
  }
}


