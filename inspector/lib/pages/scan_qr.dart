import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_inspector/pages/processing.dart';
import 'package:morpheus_inspector/store/actions.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }
}

typedef StringCallback = void Function(String url);

class QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StringCallback>(
      converter: (store) { return (url) => store.dispatch(ScanUrlAction(url)); },
      builder: (context, callback) => Scaffold(
        appBar: AppBar(
          title: Text('Scan QR'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) => this._onQRViewCreated(context, controller, callback),
                )
            )
          ],
        ))
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller, StringCallback callback) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      callback(scanData);

      Navigator.pop(context);
      await Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => Processing()
          )
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
