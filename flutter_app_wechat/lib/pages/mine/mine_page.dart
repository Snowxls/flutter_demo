import 'package:flutter/material.dart';
import 'package:flutterappwechat/pages/discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var _lineRow = Row(
    children: <Widget>[
      Container(width: 50, height: 0.5, color: Colors.white),
      Container(height: 0.5),
    ],
  );

  Widget headWidget() {
    return Container(
      color: Colors.white,
      height: 200,
      child: Container(
//        color: Colors.yellow,
        margin: EdgeInsets.only(
          top: 100,
          bottom: 20,
        ),
//        padding: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.only(left: 30),
//          padding: EdgeInsets.all(5),
//          color: Colors.red,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                // 给图片切圆角 需要在装饰器里设置图片
                decoration: BoxDecoration(
                  color: Colors.blue,
                  //设置圆角、阴影等效果
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('images/Snow.jpeg'),
                    fit: BoxFit.cover, //填充方式
                  ),
                ),
              ), //头像
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 10,
                  right: 5,
                ),
                width: MediaQuery.of(context).size.width -
                    100, //MediaQuery.of(context).size 屏幕size
//                color: Colors.blue,
//                padding: EdgeInsets.only(left: 10), //左间距设置10
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //上下布局
                  children: <Widget>[
                    Container(
//                      color: Colors.yellow,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Snow',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ), //昵称
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '微信号：snowxls',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Image(
                            image: AssetImage('images/icon_right.png'),
                            width: 15,
                          )
                        ],
                      ),
                    ), //微信号+箭头
                  ],
                ),
              ), //右边detail
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('我'),
//      ),
      body: Stack(
        children: <Widget>[
          Container(
              color: Color.fromRGBO(220, 220, 220, 1),
              child: MediaQuery.removePadding(
                removeTop: true, //移除刘海部分的留白
                context: context,
                child: ListView(
                  children: <Widget>[
                    headWidget(), //头部
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信 支付.png',
                      title: '支付',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信收藏.png',
                      title: '收藏',
                    ),
                    _lineRow,
                    DiscoverCell(
                      imageName: 'images/微信相册.png',
                      title: '相册',
                    ),
                    _lineRow,
                    DiscoverCell(
                      imageName: 'images/微信卡包.png',
                      title: '卡包',
                    ),
                    _lineRow,
                    DiscoverCell(
                      imageName: 'images/微信表情.png',
                      title: '表情',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      imageName: 'images/微信设置.png',
                      title: '设置',
                    ),
                  ],
                ),
              )), //列表
          Container(
            height: 25,
            margin: EdgeInsets.only(top: 40, right: 10),
//            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, //居右
              children: <Widget>[
                Image(
                  image: AssetImage('images/相机.png'),
                )
              ],
            ),
          ), //相机
        ],
      ),
    );
  }
}
