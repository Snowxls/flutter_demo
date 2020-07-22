import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  return runApp(MyApp(
//    pageIndex: window.defaultRouteName,
      ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pageIndex = 'one';
  final MethodChannel _oneChannel = MethodChannel('one_page');
  final MethodChannel _twoChannel = MethodChannel('two_page');
  final BasicMessageChannel _msgChannel =
      BasicMessageChannel('messageChannel', StandardMessageCodec());

  @override
  void initState() {
    _msgChannel.setMessageHandler((message) {
      print('收到ios信息$message');
      return null;
    });

    _oneChannel.setMethodCallHandler((call) {
      setState(() {
        pageIndex = call.method;
      });
      return null;
    });
    _twoChannel.setMethodCallHandler((call) {
      setState(() {
        pageIndex = call.method;
      });
      return null;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _rootPage(pageIndex),
    );
  }

  Widget _rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one':
        {
          return Scaffold(
            appBar: AppBar(
              title: Text(pageIndex),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(pageIndex),
                  onPressed: () {
                    MethodChannel('one_page').invokeMapMethod('exit');
                  },
                ),
                TextField(
                  onChanged: (String str) {
                    _msgChannel.send(str);
                  },
                ),
              ],
            ),
          );
        }
      case 'two':
        {
          return Scaffold(
            appBar: AppBar(
              title: Text(pageIndex),
            ),
            body: Center(
              child: RaisedButton(
                child: Text(pageIndex),
                onPressed: () {
                  MethodChannel('two_page').invokeMapMethod('exit');
                },
              ),
            ),
          );
        }
      default:
        {
          return Scaffold(
            appBar: AppBar(
              title: Text('default'),
            ),
            body: Center(
              child: Text('default'),
            ),
          );
        }
    }
  }
}

//class MyApp extends StatelessWidget {
//  final String pageIndex;
//  const MyApp({Key key, this.pageIndex}) : super(key: key);
//
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: _rootPage(pageIndex),
//    );
//  }
//
//  Widget _rootPage(String pageIndex) {
//    switch (pageIndex) {
//      case 'one':
//        {
//          return Scaffold(
//            appBar: AppBar(
//              title: Text(pageIndex),
//            ),
//            body: Center(
//              child: RaisedButton(
//                child: Text(pageIndex),
//                onPressed: () {
//                  MethodChannel('one_page').invokeMapMethod('exit');
//                },
//              ),
//            ),
//          );
//        }
//      case 'two':
//        {
//          return Scaffold(
//            appBar: AppBar(
//              title: Text(pageIndex),
//            ),
//            body: Center(
//              child: RaisedButton(
//                child: Text(pageIndex),
//                onPressed: () {
//                  MethodChannel('two_page').invokeMapMethod('exit');
//                },
//              ),
//            ),
//          );
//        }
//      default:
//        {
//          return Scaffold(
//            appBar: AppBar(
//              title: Text('default'),
//            ),
//            body: Center(
//              child: Text('default'),
//            ),
//          );
//        }
//    }
//  }
//}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
