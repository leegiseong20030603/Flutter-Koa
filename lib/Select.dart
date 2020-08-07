import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  void loginButtonChecked() async {
    try {
      String authCode = await AuthCodeClient.instance.request();
      AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
    }catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RaisedButton(
            onPressed: loginButtonChecked,
          )
      ),
    );
  }
}
