import 'package:flutter/material.dart'; //此行代码作用是导入了Material UI组件库。Material是一种标准的移动端和web端的视觉设计语言， Flutter默认提供了一套丰富的Material风格的UI组件。

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
      routes: {
        'new_page': (context) => NewRoute(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
        });
      },
//      home: MyHomePage(title: 'Flutter Demo Home Page'), //应用的首页
//      home: RounterTestRoute(),
    );
  }
}

//StatefulWidget可以拥有状态，这些状态在widget生命周期中是可以变的，而Stateless widget是不可变的
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//持有的状态在widget生命周期中可能会发生变化
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  //按钮点击时触发的方法
  void _incrementCounter() {
    //通知Flutter框架，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面
    setState(() {
      _counter++; //用于记录按钮点击的总次数
    });
  }

  //路由跳转的方法
  void gotoNewController() {
    /* MaterialPageRoute继承自PageRoute类，PageRoute类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，它还定义了路由构建及切换时过渡动画的相关接口及属性。
    MaterialPageRoute({
      WidgetBuilder builder, //是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
      RouteSettings settings, //包含路由的配置信息，如路由名称、是否初始路由（首页
      bool maintainState = true, //默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为false
      bool fullscreenDialog = false,//表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）
    })
     */

    var newControl = MaterialPageRoute(
      builder: (context) {
        return NewRoute();
      },
      fullscreenDialog: true, //用来控制水平滑出push 还是 垂直进入present 默认false 水平
    );

    Future _future = Navigator.push(context,
        newControl); //是一个路由管理的组件，它提供了打开和退出路由页方法。Navigator通过一个栈来管理活动路由集合。通常当前屏幕显示的页面就是栈顶的路由。

    print(_future);
  }

  //构建UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //是 Material 库中提供的页面脚手架，它提供了默认的导航栏、标题和包含主屏幕widget树（后同“组件树”或“部件树”）
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              child: Text('goto New Controller'),
              textColor: Colors.blue,
              onPressed: () {
                //导航到新路由 新Controller
                gotoNewController();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, //点击时触发的方法
        tooltip: 'Increment444', //长按后会出现的文字
        child: Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatefulWidget {
  @override
  _NewRouteState createState() => _NewRouteState();
}

class _NewRouteState extends State<NewRoute> {
  void _backController() {
    Navigator.pop(context, '233');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NewRounte -- Controller'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('New Controller'),
            ),
            FlatButton(
              child: Text('back Controller'),
              textColor: Colors.blue,
              onPressed: () {
                //回退
                _backController();
              },
            )
          ],
        ));
    ;
  }
}

class TipRoute extends StatelessWidget {
  TipRoute(
    @required this.text,
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, 'back thing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RounterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          //打开 TipRoute 并等待返回结果
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TipRoute('提示xxxx');
            }),
          );

          print('$result');
        },
        child: Text('open'),
      ),
    );
  }
}
