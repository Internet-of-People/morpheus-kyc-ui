import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:morpheus_inspector/pages/result.dart';
import 'package:morpheus_inspector/view_model_provider.dart';

class QrScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QrScanPageState();
  }
}

typedef StringCallback = void Function(String url);

class QrScanPageState extends State<QrScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  StreamSubscription<String> subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController controller) {
                  this.controller = controller;
                  this.subscription = controller.scannedDataStream.listen((scanData) async {
                    controller.pauseCamera();
                    ViewModel.of(context).gotUrl(scanData);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage()));
                  });
                },
              )
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    controller?.dispose();
    super.dispose();
  }
}
