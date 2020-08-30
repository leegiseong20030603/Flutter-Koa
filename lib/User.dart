import 'dart:convert';

class User{
  String id, pw, name, email, birthday, type, image, creation_date, agree;

  static User sign;

  User({this.id, this.pw, this.name, this.email, this.birthday, this.type, this.image,this.creation_date, this.agree}){
    sign = this;
  }

  User.Reset({this.id, this.pw, this.name, this.email, this.birthday, this.type, this.image,this.creation_date, this.agree});

  factory User.instance() => sign;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'type' : type,
    'image' : image,
  };

  User.fromjson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }
}
