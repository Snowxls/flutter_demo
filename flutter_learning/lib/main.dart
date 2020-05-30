import 'package:flutter/material.dart'; //此行代码作用是导入了Material UI组件库。Material是一种标准的移动端和web端的视觉设计语言， Flutter默认提供了一套丰富的Material风格的UI组件。

import 'home.dart';

//应用入口
void main() {
  runApp(MyApp());
}

//应用结构
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        //蓝色主题
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      routes: {
//        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
//        'ViewControll1': (context) => VC1(),
//        'ViewControll2': (context) => VC2(),
//      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          print('MaterialPageRoute ---- $routeName');
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
        });
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'), //应用的首页
//      home: RounterTestRoute(),
    );
  }
}
