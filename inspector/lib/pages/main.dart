import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morpheus_inspector/pages/scan_qr.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

// Some icons made by [Freepik](https://www.flaticon.com/authors/freepik)

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Morpheus Inspector')),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => QrScan()
            ));
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/qr-code.svg',
              width: 128,
              height: 128,
              semanticsLabel: 'Scan QR code',
            )
          ),
      ),
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
    );
  }
}
