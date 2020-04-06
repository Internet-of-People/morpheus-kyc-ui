import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/inspector_scenarios/inspector_scenarios.dart';
import 'package:morpheus_kyc_user/shared_prefs.dart';
import 'package:morpheus_sdk/authority.dart';
import 'package:morpheus_sdk/inspector.dart';
import 'package:pedantic/pedantic.dart';
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
                  onQRViewCreated: (QRViewController controller) async {
                    this.controller = controller;
                    controller.scannedDataStream.listen((scanData) async {
                      controller.pauseCamera();

                      // TODO: endpoints must advertise what type they are
                      if(await _isAuthorityApi(scanData)) {
                        await AppSharedPrefs.setAuthorityUrl(scanData);
                        unawaited(Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListAvailableProcessesPage()
                          )
                        ));
                      }
                      else if(await _isInspectorApi(scanData)) {
                        await AppSharedPrefs.setInspectorUrl(scanData);
                        unawaited(Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InspectorScenariosPage()
                          )
                        ));
                      }
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

  Future<bool> _isAuthorityApi(String url) async {
    try {
      await AuthorityPublicApi(url).listProcesses();
      return true;
    }
    catch(e) {
      // Nothing to do here
    }
    return false;
  }

  Future<bool> _isInspectorApi(String url) async {
    try {
      await InspectorPublicApi(url).listScenarios();
      return true;
    }
    catch(e) {
      // Nothing to do here
    }
    return false;
  }
}
