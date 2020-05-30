import 'package:flutter/material.dart';
import 'package:flutterappwechat/pages/chat_page.dart';
import 'package:flutterappwechat/pages/diccover_page.dart';
import 'package:flutterappwechat/pages/friends_page.dart';
import 'package:flutterappwechat/pages/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  List<Widget> _pages = [ChatPage(), FriendsPage(), DiscoverPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0, //选中时字体大小
        onTap: (index) {
          setState(() {
            // 刷新UI
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, //固定布局
        fixedColor: Colors.green,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('微信'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('通讯录'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('我'),
          ),
        ],
      ),
    );
    ;
  }
}
