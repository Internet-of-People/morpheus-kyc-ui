import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/morpheus-color.dart';

import 'create-witness-request.dart';
//import 'package:morpheus_kyc_user/scan-qr.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Morpheus')),
      body: const Center(child: Text('Welcome to Morpheus!')),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: PRIMARY_COLOR,
            ),
            margin: EdgeInsets.zero,
            child: const Text(
              'Morpheus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.content_paste),
            title: const Text('Create Witness Request'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateWitnessRequestPage()
                  )
              );
            },
          ),
        ],
      )),
    );
  }
}
