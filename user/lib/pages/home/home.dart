import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/drawer/drawer.dart';

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
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Image(image: AssetImage('assets/Icon-512x512.png'),width: 100,),
            ),
            const Text('Welcome to Morpheus!', style: TextStyle(
              fontSize: 24
            )),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text('This application is for user participants described in the Morpheus specification.'),
            )
          ],
        )
      ),
      drawer: MainDrawer()
    );
  }
}
