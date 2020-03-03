import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/sdk/native_sdk.dart';
import 'package:morpheus_inspector/pages/available_processes/available_processes.dart';
import 'package:morpheus_inspector/pages/drawer/header.dart';
import 'package:morpheus_inspector/pages/requests/requests.dart';
import 'package:morpheus_inspector/pages/scan_qr/scan_qr.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Header(NativeSDK.instance.listDids()),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Scan Authority Info'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScanQRPage()
                    )
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.android),
              title: const Text('Emulator'),
              onTap: () {
                AuthorityApi.setAsRealDevice('http://34.76.108.115:8080');
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListAvailableProcessesPage()
                    )
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('Requests'),
              onTap: () {
                AuthorityApi.setAsRealDevice('http://34.76.108.115:8080');
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestsPage()
                    )
                );
              },
            ),
          ],
        )
    );
  }
}