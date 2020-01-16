import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignRequestPage extends StatefulWidget {
  final String _processName;

  const SignRequestPage(this._processName, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignRequestPageState();
  }
}

class SignRequestPageState extends State<SignRequestPage> {
  String selectedDid = 'did:morpheus:ezFoo1';
  String selectedKey = 'key1';

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
            DropdownButton<String>(
              value: selectedDid,
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
                  selectedDid = newValue;
                });
              },
              items: <String>['did:morpheus:ezFoo1', 'did:morpheus:ezFoo2']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
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
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    final url = 'mailto:<email address>?subject=<subject>&body=<body>';
                    if(await canLaunch(url)){
                      await launch(url);
                    }
                    else {
                      print('Could not launch $url');
                    }
                  },
                  child: Text(
                    'Sign',
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}