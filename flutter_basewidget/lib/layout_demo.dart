import 'package:flutter/material.dart';

//Row 横向
//Column 纵向
//Stack 叠加
/*
  关于主轴 mainAxisAlignment
  start - 默认值 主轴起始点对齐
  center - 主轴中对齐
  end - 主轴结束点对齐
  spaceAround - 剩余空间平均分给每个子部件周围
  spaceBetween - 剩余空间平均分给每个子部件之间
  spaceEvenly - 剩余空间和子部件一起平均分布
*/
/*
  关于交叉轴 crossAxisAlignment 交叉点为主轴的垂直轴
  start - 默认值 交叉轴起始点对齐
  center - 交叉轴中对齐
  end - 交叉轴结束点对齐
  baseline - 如果子部件中有文字 会以文字的底部为基准底对齐
  stretch - 剩余空间拉伸填充
*/
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      alignment: Alignment(0.0, 0.0), //x,y的0点是屏幕中央 左上为（-1，-1）
//      child: AspectDemo(),
//      child: StackDemo(),
//      child: RowDemo(),
      child: ColumnDemo(),
    );
  }
}

//Positioned - top,left,right,bottom 是相对于Stack容器来调整距离的
class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
//          right: 0,
            child: Container(
          color: Colors.white,
          width: 200,
          height: 200,
          child: Icon(Icons.add),
        )),
        Positioned(
          right: 0,
          top: 20,
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
            child: Icon(Icons.add),
          ),
        ),
        Positioned(
//          left: 1,
          child: Container(
            color: Colors.red,
            width: 50,
            height: 50,
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class AspectDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 300,
//      height: 300, //优先外部的属性
      child: AspectRatio(
        aspectRatio: 2 / 1, //宽高比
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

class RowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //主轴 默认start
      crossAxisAlignment: CrossAxisAlignment.baseline, //交叉轴 默认start
      textBaseline: TextBaseline.ideographic, //当子部件中有文字 会以文字的底部为基准对齐
      //alphabetic 英文字符
      //ideographic 中文字符
      children: <Widget>[
        //主轴填充完
        Expanded(
          child: Container(
            color: Colors.red,
            child: Icon(Icons.add, size: 120),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Icon(Icons.add, size: 100),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.green,
            child: Icon(Icons.add, size: 60),
          ),
        ),
      ],
    );
  }
}

class ColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //主轴 默认start
      crossAxisAlignment: CrossAxisAlignment.baseline, //交叉轴 默认start
      textBaseline: TextBaseline.ideographic, //当子部件中有文字 会以文字的底部为基准对齐
      //alphabetic 英文字符
      //ideographic 中文字符
      children: <Widget>[
        //主轴填充完
        Expanded(
          child: Container(
            color: Colors.red,
            child: Icon(Icons.add, size: 120),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Icon(Icons.add, size: 100),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.green,
            child: Icon(Icons.add, size: 60),
          ),
        ),
      ],
    );
  }
}
