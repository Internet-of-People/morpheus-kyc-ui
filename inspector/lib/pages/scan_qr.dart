import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redux/redux.dart';

import 'package:morpheus_inspector/store/actions.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:morpheus_inspector/store/routes.dart';

class QrScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QrScanPageState();
  }
}

class _QrScanViewModel {
  final Function _dispatch;

  _QrScanViewModel(Store<AppState> store):
    _dispatch = store.dispatch;

  scanned(String url) {
    _dispatch(ScanUrlAction(url));
    _dispatch(NavigateToAction.replace(Routes.processing));
  }
}

typedef StringCallback = void Function(String url);

class _QrScanPageState extends State<QrScanPage> {
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
