import 'dart:convert';

class User{
  String id, pw, name, email, birthday, type, image, creation_date, agree;

//  static final User _Instance = User._internal(id,pw,name,email,birthday,type,image,creation_date,agree);
 // static User get instace => _Instance;
  User(this.id, this.pw, this.name, this.email, this.birthday, this.type, this.image,this.creation_date, this.agree);

  Instance(){ // Instance
   // return _Instance;
  }

  User._internal(String id, String pw, String name, String birthday, String type, String image, String creation_date, String agree){ // 초기화
//    User user = User(id,pw,name,email,birthday,type,image,creation_date,agree);
//    return user;
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
