import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/authority_private_api.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/inspector_private_api.dart';
import 'package:morpheus_common/sdk/inspector_public_api.dart';
import 'package:morpheus_common/sdk/native_sdk.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/drawer/header.dart';
import 'package:morpheus_kyc_user/pages/inspector_scenarios/inspector_scenarios.dart';
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
              title: const Text('Scan QR'),
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
              title: const Text('Authority Test'),
              onTap: () {
                //AuthorityPublicApi.setAsRealDevice('http://34.76.108.115:8080');
                //AuthorityPrivateApi.setAsRealDevice('http://34.76.108.115:8080');
                AuthorityPublicApi.setAsEmulator();
                AuthorityPrivateApi.setAsEmulator();
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
              leading: const Icon(Icons.android),
              title: const Text('Inspector Test'),
              onTap: () {
                //InspectorPublicApi.setAsRealDevice('http://34.76.108.115:8080');
                //InspectorPrivateApi.setAsRealDevice('http://34.76.108.115:8080');
                InspectorPublicApi.setAsEmulator();
                InspectorPrivateApi.setAsEmulator();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InspectorScenariosPage()
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