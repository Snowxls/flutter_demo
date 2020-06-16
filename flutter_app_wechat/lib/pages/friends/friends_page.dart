import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterappwechat/common.dart';
import 'package:flutterappwechat/pages/discover/discover_child_page.dart';
import 'package:flutterappwechat/pages/friends/friends_data.dart';
import 'package:flutterappwechat/pages/friends/index_bar.dart';

import 'friends_cell.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController; //滚动控制器
  //字典 放item和高度的对应数据
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0, //放大镜
    INDEX_WORDS[1]: 0.0, //五角星
  };

  final List<Friends> _listDatas = [];

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void initState() {
    // 初始化的时候会调用
    super.initState();

    //数据添加
    _listDatas.addAll(datas); //加入所有数据
    // 可以多次添加
    _listDatas.addAll(datas);
    _listDatas.addAll(datas);

    _listDatas..addAll(datas)..addAll(datas); //链式

    //排序
    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });

    _scrollController = ScrollController();

    var _groupOffset = 54.5 * _headerData.length; //头部的4个控件不计算在内
    //经过循环 将每一个头的位置算出来 放入字典
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1) {
        //第一个cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完再加偏移量
        _groupOffset += 84.5; //84.5是一个cell的高度
      } else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //判断有没有头
        //没有头 直接加普通cell的高度
        _groupOffset += 54.5;
      } else {
        //余下有头部的cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84.5; //84.5是一个cell的高度
      }
    }
  }

  final List<Friends> _headerData = [
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
      // 显示剩下的cell
      //如果当前和上一个cell的indexLetter一样 就不显示
      if (index - 4 > 0 &&
          _listDatas[index - 4].indexLetter ==
              _listDatas[index - 5].indexLetter) {
        return FriendCell(
          imageUrl: _listDatas[index - 4].imageUrl,
          name: _listDatas[index - 4].name,
        );
      } else {
        return FriendCell(
          imageUrl: _listDatas[index - 4].imageUrl,
          name: _listDatas[index - 4].name,
          groupTitle: _listDatas[index - 4].indexLetter,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text(
          '通讯录',
          style: TextStyle(color: Colors.black),
        ),
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
      body: Stack(
        children: <Widget>[
          Container(
            color: WeChatThemeColor,
            child: ListView.builder(
              itemCount: _headerData.length + _listDatas.length,
              itemBuilder: _itemForCell,
              controller: _scrollController, //设置滚动控制器
            ),
          ), //tableView列表
          IndexBar(
            indexBarCallBack: (String str) {
              print('选中${str}');
              //先判断有没有这个值 没有则不滚动
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(
                  _groupOffsetMap[str],
                  duration: Duration(microseconds: 1000),
                  curve: Curves.easeIn,
                );
              }
            },
          ), //悬浮检索控件
        ],
      ),
    );
  }
}
