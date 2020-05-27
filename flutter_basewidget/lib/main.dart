import 'package:flutter/material.dart';
import 'layout_demo.dart';
import 'listview_demo.dart';
import 'model/car.dart';
import 'base_widget.dart';


void main() {
  Car c = Car(
      name:'Snow',
      imageUrl:'url');
//  c.imageUrl = '566';
//  Car c = Car.fromList(['snow','url222']);
//  Car c = Car.defaults('snow', 'url');
  print('\nname:'+ c.name + '\nurl:' + c.imageUrl);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData( //主题
        primaryColor: Colors.yellow,
      ),
    );

  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[80],
      appBar: AppBar(
        title: Text('Flutter_BaseWidget'),
      ),
      body: ListViewDemo(),
//      body: ContainerDemo(),
    );

  }
}

