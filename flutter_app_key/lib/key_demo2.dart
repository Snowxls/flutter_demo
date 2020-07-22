//GlobalKey的使用
//关于Stateful 尽量在末端 在树的叶子节点处

import 'package:flutter/material.dart';

class GlobalKeyDemo extends StatelessWidget {
  final GlobalKey<_ChildPageState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlobalKeyDemoo'),
      ),
      body: ChildPage(
        key: _globalKey,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //在StatelessWidget中改变StatefulWidget里的内容并刷新UI
            _globalKey.currentState._count++;
            _globalKey.currentState.data =
                'old' + _globalKey.currentState._count.toString();
            _globalKey.currentState.setState(() {});
          }),
    );
  }
}

class ChildPage extends StatefulWidget {
  ChildPage({Key key}) : super(key: key);
  @override
  _ChildPageState createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  int _count = 0;
  String data = 'hello';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(_count.toString()),
          Text(data),
        ],
      ),
    );
  }
}
