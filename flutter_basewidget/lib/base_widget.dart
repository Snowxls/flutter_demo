import 'package:flutter/material.dart';

//TextView 普通文本
class TextDemo extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(
    fontSize: 16.0,
  );

  final String _title = 'Flutter';
  final String _user = 'Snow';

  @override
  Widget build(BuildContext context) {
    return Text(
      '《${_title} -- 副标题》 -- $_user \n测试一下Text文本显示；123321爱asdklsadkljasdklasd数据啊了肯定接口里撒娇的撒基督教asdsadasdasddadsadada撒旦教萨克劳动局啊来得及啦所多???Snow',
      textAlign: TextAlign.center,
      style: _textStyle,
      maxLines: 4, //最大行数
      overflow: TextOverflow.ellipsis, //多出部分显示...
    );
  }
}

//TextView 富文本
class RichTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Flutter文本Demo\n',
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: 'Warlock',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              )),
          TextSpan(
              text: 'Snow',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}

//Container
class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Icon(
              Icons.add,
              size: 45,
            ),
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),//内边距
            margin: EdgeInsets.all(10),//外边距
            width:200,
            height: 200,
          )
        ],
      ),
    );
  }
}
