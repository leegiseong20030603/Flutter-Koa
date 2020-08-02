import 'dart:async';

import 'package:exmaple/Login.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed("/LoginPage"));
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
