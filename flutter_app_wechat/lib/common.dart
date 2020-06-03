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
