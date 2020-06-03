import 'package:flutter/material.dart';
import 'package:flutterappwechat/common.dart';
import 'package:flutterappwechat/pages/discover/discover_child_page.dart';
import 'package:flutterappwechat/pages/friends/friends_data.dart';

import 'friends_cell.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List _headerData = [
    Friends(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageUrl: 'images/群聊.png', name: '群聊'),
    Friends(imageUrl: 'images/标签.png', name: '标签'),
    Friends(imageUrl: 'images/公众号.png', name: '公众号'),
  ];

  //cell
  Widget _itemForCell(BuildContext context, int index) {
    if (index < _headerData.length) {
      //显示头部
      return FriendCell(
        imageAsset: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    } else {
      return FriendCell(
        imageUrl: datas[index - 4].imageUrl,
        name: datas[index - 4].name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text('通讯录'),
        actions: <Widget>[
          //从右边开始
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return DisCoverChildPage(
                  title: '添加朋友',
                );
              }));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 25,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _headerData.length + datas.length,
        itemBuilder: _itemForCell,
      ),
    );
  }
}
