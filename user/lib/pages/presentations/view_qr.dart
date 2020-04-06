import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewQrPage extends StatelessWidget {
  final String _url;

  const ViewQrPage(this._url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: _url,
              version: QrVersions.auto,
              size: 300.0,
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CLOSE',
                style: TextStyle(fontSize: 14.0),
              ),
            )
        ],),
      ),
    );
  }
}