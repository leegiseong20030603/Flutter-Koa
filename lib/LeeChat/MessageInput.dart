import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {

  final TextEditingController message_Controller;
  final Function Message_send_onPressed, plus_onPressed;
  Icon icon;

  MessageInput({@required this.message_Controller, this.Message_send_onPressed, this.plus_onPressed, this.icon});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {

  final GlobalKey<ScaffoldState> _scafflodKey = GlobalKey<ScaffoldState>();

  Color _color;
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scafflodKey,
      body: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: widget.icon,
                  onPressed: widget.plus_onPressed,
                ),
              ),
              Flexible(
                flex: 9,
                child: TextField(
                  maxLines: 100,
                  controller: widget.message_Controller,
                  onChanged: (value) {
                    if(value.isNotEmpty){
                      setState(() {
                        _color = Colors.lightBlueAccent;
                      });
                    }else{
                      setState(() {
                        _color = Colors.grey;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "메세지를 입력하세요...."),
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  color: _color,
                  onPressed: widget.Message_send_onPressed,
                  icon: Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _showBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(title: Text('Bottom sheet')),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.attach_money),
              labelText: 'Enter an integer',
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save and close'),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
