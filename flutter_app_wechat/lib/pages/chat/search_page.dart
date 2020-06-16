import 'package:flutter/material.dart';

import 'chat_page.dart';
import 'search_bar.dart';

class SearchPage extends StatefulWidget {
  final List<Chat> datas;
  const SearchPage({this.datas});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Chat> _models = []; //需要显示的内容 （筛选后的结果）

  void _searchData(String text) {
    _searchStr = text;
    //每次进来都是重新搜索
    _models.clear();
    if (text.length > 0) {
      //有内容就搜索
      for (int i = 0; i < widget.datas.length; i++) {
        String name = widget.datas[i].name;
        if (name.contains(text)) {
          _models.add(widget.datas[i]);
        }
      }
    }
    setState(() {});
  }

  String _searchStr = '';
  TextStyle _normalStype = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  TextStyle _highlightStype = TextStyle(
    fontSize: 16,
    color: Colors.green,
  );
  Widget _title(String name) {
    List<TextSpan> spans = [];
    //空字符串: 1.以这个字符开头 2.以这个字符结束 3.连续出现这个字符
    List<String> strs = name.split(_searchStr);
    print(strs);
    for (int i = 0; i < strs.length; i++) {
      String str = strs[i];
      if (str == '' && i < strs.length - 1) {
        //空串 表示为截取出来的文本
        spans.add(TextSpan(
          text: _searchStr,
          style: _highlightStype,
        ));
      } else {
        //其他字符
        spans.add(TextSpan(
          text: str,
          style: _normalStype,
        ));
        if (i < strs.length - 1) {
          //只要不是最后一个字符 说明字符后必定跟着一个关键字
          spans.add(TextSpan(
            text: _searchStr,
            style: _highlightStype,
          ));
        }
      }
    }
//    for (String s in strs) {
//      if (s.length == 0) {
//        //空串 表示为截取出来的文本
//        spans.add(TextSpan(
//          text: _searchStr,
//          style: _highlightStype,
//        ));
//      } else {
//        //其他字符
//        spans.add(TextSpan(
//          text: s,
//          style: _normalStype,
//        ));
//      }
//    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildCellForRow(BuildContext context, int index) {
    return ListTile(
      title: _title(_models[index].name),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          _models[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            image:
                DecorationImage(image: NetworkImage(_models[index].imageUrl))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            onChanged: (text) {
              _searchData(text);
//              print('接收到了$text');
            },
          ),
          Expanded(
              flex: 1,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: _models.length,
                  itemBuilder: _buildCellForRow,
                ),
              )),
        ],
      ),
    );
  }
}
