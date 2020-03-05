import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:morpheus_inspector/store/actions.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:redux/redux.dart';

import '../main.dart';

class QrScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QrScanState();
  }
}

class _QrScanViewModel {
  final Store<AppState> _store;

  _QrScanViewModel(this._store);

  scanned(String url) {
    _store.dispatch(ScanUrlAction(url));
    _store.dispatch(NavigateToAction.replace(Routes.processing));
  }
}

typedef StringCallback = void Function(String url);

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _QrScanViewModel>(
      converter: (store) => _QrScanViewModel(store),
      builder: (context, vm) => Scaffold(
        appBar: AppBar(
          title: Text('Scan QR'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) => this._onQRViewCreated(context, controller, vm),
                )
            )
          ],
        ))
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller, _QrScanViewModel vm) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      vm.scanned(scanData);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
