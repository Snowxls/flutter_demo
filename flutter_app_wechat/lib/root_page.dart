import 'package:flutter/material.dart';
import 'package:flutterappwechat/pages/chat/chat_page.dart';
import 'package:flutterappwechat/pages/discover/diccover_page.dart';
import 'package:flutterappwechat/pages/friends/friends_page.dart';
import 'package:flutterappwechat/pages/mine/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  List<Widget> _pages = [ChatPage(), FriendsPage(), DiscoverPage(), MinePage()];

  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int index) {
          //页面滚动时调用
          _currentIndex = index;
          setState(() {});
        },
        controller: _controller,
        children: _pages,
        physics: NeverScrollableScrollPhysics(), //拒绝页面滚动
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0, //选中时字体大小
        onTap: (index) {
          setState(() {
            // 刷新UI
            _currentIndex = index;
          });
          _controller.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed, //固定布局
        fixedColor: Colors.green,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_chat.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_chat_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('微信'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_friends.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_friends_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('通讯录'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_discover.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_discover_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/tabbar_mine.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'images/tabbar_mine_hl.png',
              height: 20,
              width: 20,
            ),
            title: Text('我'),
          ),
        ],
      ),
    );
    ;
  }
}
