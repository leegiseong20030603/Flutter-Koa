import 'dart:convert';

class User{
  String id, pw, name, email, birthday, type, image, agree;

  static final User _Instance = User._internal();
  static User get instace => _Instance;
  User(this.id, this.pw, this.name, this.email, this.birthday, this.type, this.image, this.agree);

  Instance(){ // Instance
    return _Instance;
  }

  User._internal(){ // 초기화

  }

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
