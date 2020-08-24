import 'dart:convert';

import 'package:exmaple/User.dart';

class Message{
  String id, name, message, time, image;
  int direction;

  Message({this.id, this.name, this.message, this.time, this.image, this.direction});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'message' : message,
    'time' : time,
    'image' : image,
    'direction' : direction,
  };

  Message.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    message = json['message'];
    time = json['time'];
    image = json['image'];
    direction = json['direction'];
  }
}