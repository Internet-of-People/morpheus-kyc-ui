import 'package:flutter/material.dart';

import '../drawer/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Morpheus')),
      body: Center(child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Welcome to Morpheus!', style: TextStyle(
                fontSize: 24
            )),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text('This application is for users described in the KYC use case.'),
            )
          ],
        )
      ),
      drawer: MainDrawer()
    );
  }
}
