import 'package:flutter/material.dart';
import 'package:morpheus_common/utils/morpheus_color.dart';

class SignRequestPage extends StatefulWidget {
  final String _processName;

  const SignRequestPage(this._processName, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignRequestPageState();
  }
}

class SignRequestPageState extends State<SignRequestPage> {
  String selectedKey = 'key1';

  void onSignButtonPressed() async {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Confirm Signing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('You\'r about to sign with this key:'),
                Text('$selectedKey', style: Theme.of(context).textTheme.caption),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL', style: TextStyle(color: Colors.black45)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('SIGN'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._processName),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child: DropdownButton<String>(
                  value: selectedKey,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: Colors.deepPurple
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      selectedKey = newValue;
                    });
                  },
                  items: <String>['key1', 'key2']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
              ]
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Sign'),
        icon: const Icon(Icons.create),
        backgroundColor: primaryMaterialColor,
        onPressed: onSignButtonPressed,
      ),
    );
  }
}