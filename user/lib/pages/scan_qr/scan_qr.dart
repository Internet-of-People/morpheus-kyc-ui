import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/authority_private_api.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScanQRPageState();
  }
}

class ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

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
                  onQRViewCreated: (QRViewController controller){
                    this.controller = controller;
                    controller.scannedDataStream.listen((scanData) {
                      controller.pauseCamera();
                      AuthorityPublicApi.setAsRealDevice(scanData);
                      AuthorityPrivateApi.setAsRealDevice(scanData);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListAvailableProcessesPage()
                          )
                      );
                    });
                  },
                )
            )
          ],
        ));
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
