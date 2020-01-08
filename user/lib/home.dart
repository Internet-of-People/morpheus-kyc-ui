import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // http://127.0.0.1/morpheus/witness-service
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('a')
          ],
        ),
      ),
    );
  }
}