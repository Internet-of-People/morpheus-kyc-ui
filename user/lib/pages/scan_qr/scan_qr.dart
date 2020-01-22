import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/store/state.dart';
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
                child: StoreConnector(
                  converter: (Store<AppState> store) => (String apiUrl) => store.dispatch(SetAuthorityApiUrlAction(apiUrl)),
                  builder: (context, setAuthorityApiUrl){
                    return QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller){
                        this.controller = controller;
                        controller.scannedDataStream.listen((scanData) {
                          controller.pauseCamera();
                          setAuthorityApiUrl(scanData);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListAvailableProcessesPage()
                              )
                          );
                        });
                      },
                    );
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
