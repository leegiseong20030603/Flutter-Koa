import 'dart:convert';

class User{
  String id, pw, name, email, birthday, type, image;

  User(this.id, this.pw, this.name, this.email, this.birthday, this.type);

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
