import 'package:flutter/material.dart';
import 'package:flutterappwechat/root_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //颜色初始化
        highlightColor: Color.fromRGBO(1, 0, 0, 0), //长按的颜色
        splashColor: Color.fromRGBO(1, 0, 0, 0), //点击的颜色
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootPage(),
    );
  }
}
