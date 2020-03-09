import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/authority_private_api.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/native_sdk.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/drawer/header.dart';
import 'package:morpheus_kyc_user/pages/requests/requests.dart';
import 'package:morpheus_kyc_user/pages/scan_qr/scan_qr.dart';

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
                AuthorityPublicApi.setAsRealDevice('http://34.76.108.115:8080');
                AuthorityPrivateApi.setAsRealDevice('http://34.76.108.115:8080');
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
                AuthorityPublicApi.setAsRealDevice('http://34.76.108.115:8080');
                AuthorityPrivateApi.setAsRealDevice('http://34.76.108.115:8080');
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