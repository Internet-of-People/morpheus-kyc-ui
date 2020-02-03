import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: Future.delayed(Duration(seconds: 1)),
    builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(title: const Text('Witness')),
        body: SingleChildScrollView(
          child: ListView.builder(
            itemCount: _processes.length,
            itemBuilder:(context, int index) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text('d'),
                    subtitle: Text('asd'),
                    onTap: () {
                    },
                  ),
                ],
              );
            }
          ),
        )
      );
    },
  );
}