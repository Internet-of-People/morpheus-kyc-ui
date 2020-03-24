import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:morpheus_inspector/pages/result.dart';
import 'package:morpheus_inspector/pages/scan_qr.dart';
import 'package:morpheus_inspector/shared_prefs.dart';
import 'package:morpheus_inspector/view_model_provider.dart';

final url1 = 'http://${TestUrls.gcpValidator}/blob/cju-WutB5_FzMH4dIkdJzhuTarsNoI3xeUNu56mG4gFWSE';
final url2 = 'whatever';
final url3 = 'whatever';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: const Text('Morpheus Inspector')),
          floatingActionButton: _buildFab(context),
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
                  const Text('Welcome to Morpheus!',
                      style: TextStyle(fontSize: 24)),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const Text(
                        'This is a sample application for the swimming pool cashiers described in the Morpheus specification.'),
                  )
                ],
              ),
          ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return SpeedDial(
      onPress: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanPage())),
      child: Padding(
          padding: EdgeInsets.all(8),
          child: SvgPicture.asset(
            'assets/qr-code.svg',
            width: 128,
            height: 128,
            semanticsLabel: 'Scan QR code',
          )),
      //visible: _fabExtended,
      children: [
        SpeedDialChild(
          label: '0% test',
          onTap: () => _toResult(context, url1),
          child: Icon(Icons.looks_one),
        ),
        SpeedDialChild(
          label: '5% test',
          onTap: () => _toResult(context, url2),
          child: Icon(Icons.looks_two),
        ),
        SpeedDialChild(
          label: '10% test',
          onTap: () => _toResult(context, url3),
          child: Icon(Icons.looks_3),
        ),
      ],
    );
  }

  void _toResult(BuildContext context, String url) {
    ViewModel.of(context).gotUrl(url);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage()));
  }
}
