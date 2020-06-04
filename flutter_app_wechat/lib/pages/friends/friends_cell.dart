import 'package:flutter/material.dart';
import 'package:flutterappwechat/common.dart';

class FriendCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAsset;

  const FriendCell(
      {this.imageUrl, this.name, this.groupTitle, this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: groupTitle != null ? 30 : 0,
          color: Color.fromRGBO(1, 1, 1, 0),
          child: groupTitle != null
              ? Text(
                  groupTitle,
                  style: TextStyle(color: Colors.grey),
                )
              : null,
        ), //cell的头
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage(imageAsset)),
                ),
              ), //图片
              Container(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              ), //文字
            ],
          ),
        ), //cell内容
        Container(
          height: 0.5,
          color: WeChatThemeColor,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                color: Colors.white,
              )
            ],
          ),
        ), //分割线
      ],
    );
  }
}
