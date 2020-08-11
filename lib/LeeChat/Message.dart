import 'dart:convert';

import 'package:exmaple/User.dart';

class Message{
  String id, name, message, time;
  int direction;
  User user;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'message' : message,
    'time' : time,
    'direction' : direction,
  };

  Message.fromJson(Map<String,dynamic> json){
    id = User.fromjson(json['id']) as String;
    name = User.fromjson(json['name']) as String;
    message = json['message'];
    time = json['time'];
    direction = json['direction'];
  }
}