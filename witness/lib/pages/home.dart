import 'package:flutter/material.dart';
import 'package:witness/drawer/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Morpheus')),
      body: Center(child:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
            child: Image(image: AssetImage('assets/morpheus_logo.png'),width: 100,),
          ),
          const Text('Welcome to Morpheus!', style: TextStyle(
              fontSize: 24
          )),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: const Text('This application is for witness participants described in the Morpheus specification.'),
          )
        ],
      )
      ),
      drawer: MainDrawer()
  );
}