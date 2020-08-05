import 'package:flutter/material.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
            "Management",
            style: TextStyle(fontSize: 50),
          )
      ),
    );
  }
}
