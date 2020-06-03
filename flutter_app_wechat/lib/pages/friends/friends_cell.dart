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
        ),
        Container(
          height: 0.5,
          color: WeChatThemeColor,
        ),
      ],
    );
  }
}
