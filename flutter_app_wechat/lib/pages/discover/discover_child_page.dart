import 'package:flutter/material.dart';

class DisCoverChildPage extends StatelessWidget {
  final String title;
  DisCoverChildPage({
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Center(
        child: Text('$title'),
      ),
    );
  }
}
