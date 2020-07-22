import 'dart:math';

import 'package:flutter/material.dart';

class KeyDemo extends StatefulWidget {
  @override
  _KeyDemoState createState() => _KeyDemoState();
}

class _KeyDemoState extends State<KeyDemo> {
  List<Widget> items = [
    StfulItem(
      'aaa',
      key: ValueKey(111),
    ),
    StfulItem(
      'bbb',
      key: ObjectKey(Text('123')), //以object作为key
    ),
    StfulItem(
      'ccc',
      key: UniqueKey(), //以一个随机值作为key 但是是唯一的 能保证对象的key唯一性 使用后就没有复用了 每次都是强制更新
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KeyDemo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            items.removeAt(0);
          });
        },
      ),
    );
  }
}

class StfulItem extends StatefulWidget {
  final title;
  StfulItem(this.title, {Key key}) : super(key: key);

  @override
  _StfulItemState createState() => _StfulItemState();
}

class _StfulItemState extends State<StfulItem> {
  //写在State中 canUpdate 函数中 如果比对type和key没有改变（未设置key的情况下）不会重新渲染（只会更新改变过内容的对象）
  final _color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
      child: Text(widget.title),
    );
    ;
  }
}

//做一个正方形
class StlItem extends StatelessWidget {
  final title;
  StlItem(this.title);

  final _color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
      child: Text(title),
    );
  }
}
