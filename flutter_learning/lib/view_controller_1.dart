import 'package:flutter/material.dart';

import 'view_controller_2.dart';

class VC1 extends StatefulWidget {
  @override
  _VC1State createState() => _VC1State();
}

class _VC1State extends State<VC1> {
  void _backController() {
    Navigator.pop(context, '233');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Controller__1'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('This is Controller 1'),
            ),
            FlatButton(
              child: Text('back Controller'),
              textColor: Colors.blue,
              onPressed: () {
                //回退
                _backController();
              },
            ),
            RaisedButton(
              onPressed: () async {
                //打开 TipRoute 并等待返回结果
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return VC2(text: 'VC2');
                  }),
                );

                print('$result');
              },
              child: Text('goto VC2'),
            ),
          ],
        ));
  }
}
