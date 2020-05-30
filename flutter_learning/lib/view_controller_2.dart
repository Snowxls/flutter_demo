import 'package:flutter/material.dart';

class VC2 extends StatelessWidget {
  final String text;

  const VC2({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controller__2'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                child: Text('返回'),
                onPressed: () => Navigator.pop(context, 'back thing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
