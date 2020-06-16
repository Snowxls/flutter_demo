import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterappwechat/common.dart';
import 'package:flutterappwechat/http_manager.dart' as http;
import 'package:flutterappwechat/pages/chat/search_bar.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

//混入 重写 wantKeepAlive 方法 并在build中使用super
class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive {
    return true;
  }

  Widget _buildPopupMenuItem(String imageAsset, String title) {
    return Row(
      children: <Widget>[
        Image(
          image: AssetImage(imageAsset),
          width: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  List<Chat> _datas = [];

  bool _cancelConnect = false;

  Timer _t;

  CancelToken _token = CancelToken();

  @override
  void dispose() {
    print('离开了微信页面');
    //取消timer
    if (_t != null && _t.isActive) {
      _t.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

//    int _count = 0;
//    _t = Timer.periodic(Duration(seconds: 1), (timer) {
//      //print(Isolate.current.debugName);
//      _count++;
//      print(_count);
//      if (_count == 99) {
//        timer.cancel();
//      }
//    });

    print('Chat init');

    getDatas()
        .then((List<Chat> datas) {
          print('Chat get datas');
          if (!_cancelConnect) {
            //如果没有取消请求 就导入数据
            setState(() {
              _datas = datas;
            });
          }
        })
        .catchError((e) {
          print('错误$e');
          _cancelConnect = true;
        })
        .whenComplete(() {
          print('Chat complete');
        })
        .timeout(Duration(seconds: 6))
        .catchError((timeout) {
          print('Chat timeout:$timeout');
          //如果出现异常 比如超时等情况 就放弃数据
          _cancelConnect = true;
        });

    final chat = {
      'name': 'snow',
      'message': 'rua',
    };
    //Map 转 Json
    final chatJson = json.encode(chat);
    print(chatJson);
    print(chat);

    //Json 转 Map
    final newChat = json.decode(chatJson);
    print(newChat);

//    getDatas().then((value) {
//      print(value);
//    });
  }

  Future<List<Chat>> getDatas() async {
    //重置
    _cancelConnect = false;

    //异步耗时方法
    final response = await http.get(
        'http://rap2.taobao.org:38080/app/mock/257168/api/chat/list',
        timeOut: 100);
//    print(response.statusCode);
//    print(response.body);

    if (response.statusCode == 200) {
      // 获取相应数据 并转成Map类型
//      final responseBody = json.decode(response.data);
      final responseBody = response.data;
      // 转模型数组 Map中遍历的结果需要返回出去
      List<Chat> chatList = responseBody['chat_list'].map<Chat>((item) {
        return Chat.fromJson(item);
      }).toList();
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: WeChatThemeColor,
        title: Text(
          '微信',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              offset: Offset(0, 60), //控制弹窗出来的位置
              child: Image(
                image: AssetImage('images/圆加.png'),
                width: 25,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/发起群聊.png', '发起群聊'),
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/添加朋友.png', '添加朋友'),
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/扫一扫1.png', '扫一扫'),
                  ),
                  PopupMenuItem(
                    child: _buildPopupMenuItem('images/收付款.png', '收付款'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Container(
          child: _datas.length == 0
              ? Center(
                  child: Text('Loading...'),
                )
              : ListView.builder(
                  itemCount: _datas.length + 1,
                  itemBuilder: _buildCellForRow,
                ),
        ),

//        child: FutureBuilder(
//          future: getDatas(),
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            if (snapshot.connectionState == ConnectionState.waiting) {
//              //数据获取中 还未完全拿到数据
//              return Center(
//                child: Text('Loading...'),
//              );
//            } else {
//              //数据获取完成
//              return ListView(
//                children: snapshot.data.map<Widget>((item) {
//                  return ListTile(
//                    title: Text(item.name),
//                    subtitle: Container(
//                      height: 20,
//                      child: Text(item.message),
//                    ),
//                    leading: CircleAvatar(
//                      backgroundImage: NetworkImage(item.imageUrl),
//                    ),
//                  );
//                }).toList,
//              );
//            }
//          },
//        ),
      ),
    );
  }

  Widget _buildCellForRow(BuildContext context, int index) {
    if (index == 0) {
      return SearchCell(
        datas: _datas,
      );
    }
    //保证模型数组中正确的数据
    index--;
    return ListTile(
      title: Text(_datas[index].name),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          _datas[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            image:
                DecorationImage(image: NetworkImage(_datas[index].imageUrl))),
      ),
    );
  }
}

class Chat {
  final String imageUrl;
  final String name;
  final String message;

  const Chat({this.imageUrl, this.name, this.message});

  // 工厂构造 单例
  factory Chat.fromJson(Map json) {
    return Chat(
      imageUrl: json['image_url'],
      name: json['name'],
      message: json['message'],
    );
  }
}
