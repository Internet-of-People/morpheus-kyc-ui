import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morpheus_inspector/pages/scan_qr.dart';
import 'package:morpheus_inspector/store/actions.dart';
import 'package:morpheus_inspector/store/app_state.dart';
import 'package:redux/redux.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

const url1 = 'whatever';
const url2 = 'whatever';
const url3 = 'whatever';

class _HomeViewModel {
  final AppState _state;
  final Function _dispatch;

  _HomeViewModel.create(Store<AppState> store):
    _state = store.state,
    _dispatch = store.dispatch;

  Future toScanQr(BuildContext context) async {
    _dispatch(NavigateToAction.push(Routes.scan));
  }

  Future toProcessing(BuildContext context, String url) async {
    _dispatch(ScanUrlAction(url));
    _dispatch(NavigateToAction.push(Routes.processing));
  }
}

// Some icons made by [Freepik](https://www.flaticon.com/authors/freepik)
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _HomeViewModel>(
      converter: (store) => _HomeViewModel.create(store),
      builder: (context, vm) => Scaffold(
        appBar: AppBar(title: const Text('Morpheus Inspector')),
        floatingActionButton: _buildFab(context, vm),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                child: Image(
                  image: AssetImage('assets/morpheus_logo.png'),
                  width: 100,
                ),
              ),
              const Text('Welcome to Morpheus!', style: TextStyle(fontSize: 24)),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: const Text(
                    'This is a sample application for the swimming pool cashiers described in the Morpheus specification.'),
              )
            ],
      )),
    ));
  }

  Widget _buildFab(BuildContext context, _HomeViewModel vm) {
    return SpeedDial(
        onPress: () => vm.toScanQr(context),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/qr-code.svg',
              width: 128,
              height: 128,
              semanticsLabel: 'Scan QR code',
            )
        ),
        //visible: _fabExtended,
        children: [
          SpeedDialChild(
            label: '0% test',
            onTap: () => vm.toProcessing(context, url1),
            child: Icon(Icons.looks_one),
          ),
          SpeedDialChild(
            label: '5% test',
            onTap: () => vm.toProcessing(context, url2),
            child: Icon(Icons.looks_two),
          ),
          SpeedDialChild(
            label: '10% test',
            onTap: () => vm.toProcessing(context, url3),
            child: Icon(Icons.looks_3),
          ),
        ],
    );
  }
}
