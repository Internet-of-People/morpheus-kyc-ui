import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/io/api/native_sdk.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/drawer/header.dart';
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
                AuthorityApi.setAsEmulator();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListAvailableProcessesPage()
                    )
                );
              },
            )
          ],
        )
    );
  }
}