library index_bar;

import 'package:flutter/material.dart';

//主题颜色
final Color WeChatThemeColor = Color.fromRGBO(220, 220, 220, 1.0);

//屏幕宽度
double ScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//屏幕高度
double ScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// 字符数组
const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

int getIndex(BuildContext context, Offset globalPosition) {
  RenderBox box = context.findRenderObject(); //拿到box
  //拿到y值
  double y = box.globalToLocal(globalPosition).dy; //坐标系转换 转换成当前控件坐标
  //算出字符高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  //算出第几个item 并给一个取值范围
  int index = (y ~/ itemHeight).clamp(0, INDEX_WORDS.length - 1);

//  print('选中${INDEX_WORDS[index]}');
  return index;
}

class IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;

  IndexBar({this.indexBarCallBack});

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  Color _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;
  double _indicatorY = 0.0; //-1.1 ~ 1.1
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(
          fontSize: 10,
          color: Colors.grey,
        ),
      )));
    }

    return Positioned(
        right: 0.0,
        height: ScreenHeight(context) / 2,
        top: ScreenHeight(context) / 8,
        width: 120,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment(0, _indicatorY),
              width: 100,
//              color: Colors.red,
              child: _indicatorHidden
                  ? null
                  : Stack(
                      alignment: Alignment(-0.2, 0),
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                            'images/气泡.png',
                            package: 'index_bar',
                          ),
                          width: 60,
                        ),
                        Text(
                          _indicatorText,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ), //气泡
            ),
            GestureDetector(
              onVerticalDragDown: (DragDownDetails details) {
                int index = getIndex(context, details.globalPosition);
                widget.indexBarCallBack(INDEX_WORDS[index]);
//            details.globalPosition//点击的坐标信息
                setState(() {
                  _bkColor = Color.fromRGBO(1, 1, 1, 0.5);
                  _textColor = Colors.white;
                  _indicatorText = INDEX_WORDS[index];
                  _indicatorY = 2.2 / 28 * index -
                      1.1; //-1.1 ~ 1.1 跨度2.2  共28个字符 原点是-1.1 需要再减去
                  _indicatorHidden = false;
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                int index = getIndex(context, details.globalPosition);
                widget.indexBarCallBack(INDEX_WORDS[index]);
                setState(() {
                  _indicatorText = INDEX_WORDS[index];
                  _indicatorY = 2.2 / 28 * index -
                      1.1; //-1.1 ~ 1.1 跨度2.2  共28个字符 原点是-1.1 需要再减去
                  _indicatorHidden = false;
                });
              },
              onVerticalDragEnd: (DragEndDetails details) {
                setState(() {
                  _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
                  _textColor = Colors.black;
                  _indicatorHidden = true;
                });
              },
              child: Container(
                width: 20,
                color: _bkColor,
                child: Column(
                  children: words,
                ),
              ),
            ),
          ],
        )); //索引条
  }
}
