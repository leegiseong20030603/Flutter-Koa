class HttpResponse{
  bool Response;
  String User_ID;
  String User_PW;
  String User_Name;
  String User_Email;
  String User_Birthday;
  String User_Type;
  String User_Image;
  String User_Agree;

  HttpResponse.fromJson(Map<String, dynamic> json){
    Response = json['response'];
    User_ID = json['User_ID'];
    User_PW = json['User_PW'];
    User_Name = json['User_Name'];
    User_Email = json['User_Email'];
    User_Birthday = json['User_Birthday'];
    User_Image = json['User_Image'];
    User_Type = json['User_Type'];
  }
}