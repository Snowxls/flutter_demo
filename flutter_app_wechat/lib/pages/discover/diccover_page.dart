import 'package:flutter/material.dart';
import 'package:flutterappwechat/common.dart';
import 'package:flutterappwechat/pages/discover/discover_cell.dart';

class DiscoverPage extends StatefulWidget {
  Color _themColor = WeChatThemeColor;
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  var _lineRow = Row(
    children: <Widget>[
      Container(width: 50, height: 0.5, color: Colors.white),
      Container(height: 0.5),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //为了安卓设置的
        elevation: 0.0, //为了安卓使用的属性 底部边栏 设置为0就不出现了
        title: Text(
          '发现',
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        color: widget._themColor, //通过widget访问成员变量
        height: 800,
        child: ListView(
          children: <Widget>[
            DiscoverCell(
              imageName: 'images/朋友圈.png',
              title: '朋友圈',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/扫一扫2.png',
              title: '扫一扫',
            ),
            _lineRow,
            DiscoverCell(
              imageName: 'images/摇一摇.png',
              title: '摇一摇',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/看一看icon.png',
              title: '看一看',
            ),
            _lineRow,
            DiscoverCell(
              imageName: 'images/搜一搜.png',
              title: '搜一搜',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/附近的人icon.png',
              title: '附近的人',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/购物.png',
              title: '购物',
              subTitle: '618特价',
              subImageName: 'images/badge.png',
            ),
            _lineRow,
            DiscoverCell(
              imageName: 'images/游戏.png',
              title: '游戏',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '小程序',
            ),
          ],
        ),
      ),
    );
  }
}
