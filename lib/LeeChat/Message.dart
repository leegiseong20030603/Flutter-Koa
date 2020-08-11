import 'dart:convert';

import 'package:exmaple/User.dart';

class Message{
  String id, name, message, time;
  int direction;
  User user;

  Map<String, dynamic> toJson() => {
    'author' : user,
    'id' : id,
    'name' : name,
    'message' : message,
    'time' : time,
    'direction' : direction,
  };

  Message.fromJson(Map<String,dynamic> json){
    user = User.fromjson(json['user']);
    id = json['id'];
    name = json['name'];
    message = json['message'];
    time = json['time'];
    direction = json['direction'];
  }
}