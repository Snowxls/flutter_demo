import 'package:flutter/material.dart';
import 'package:flutterappwechat/common.dart';

class DisCoverChildPage extends StatelessWidget {
  final String title;
  DisCoverChildPage({
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text(
          '$title',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text('$title'),
      ),
    );
  }
}
