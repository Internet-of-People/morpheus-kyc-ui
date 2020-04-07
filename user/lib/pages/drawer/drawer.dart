import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/app_model.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/drawer/header.dart';
import 'package:morpheus_kyc_user/pages/inspector_scenarios/inspector_scenarios.dart';
import 'package:morpheus_kyc_user/pages/presentations/presentations.dart';
import 'package:morpheus_kyc_user/pages/requests/requests.dart';
import 'package:morpheus_kyc_user/pages/scan_qr/scan_qr.dart';
import 'package:morpheus_kyc_user/shared_prefs.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //Header(NativeSDK.instance.listDids()),
            Header(Provider.of<AppModel>(context, listen: false).cryptoAPI.listDids()),
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
              title: const Text('IoP Authority'),
              onTap: () {
                AppSharedPrefs.setAuthorityUrl(TestUrls.gcpAuthority);
                AppSharedPrefs.setInspectorUrl(TestUrls.gcpInspector);
                AppSharedPrefs.setVerifierUrl(TestUrls.gcpVerifier);
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
              title: const Text('IoP Inspector'),
              onTap: () {
                AppSharedPrefs.setAuthorityUrl(TestUrls.gcpAuthority);
                AppSharedPrefs.setInspectorUrl(TestUrls.gcpInspector);
                AppSharedPrefs.setVerifierUrl(TestUrls.gcpVerifier);
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
                AppSharedPrefs.setAuthorityUrl(TestUrls.gcpAuthority);
                AppSharedPrefs.setInspectorUrl(TestUrls.gcpInspector);
                AppSharedPrefs.setVerifierUrl(TestUrls.gcpVerifier);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestsPage()
                    )
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.present_to_all),
              title: const Text('Presentations'),
              onTap: () {
                AppSharedPrefs.setAuthorityUrl(TestUrls.gcpAuthority);
                AppSharedPrefs.setInspectorUrl(TestUrls.gcpInspector);
                AppSharedPrefs.setVerifierUrl(TestUrls.gcpVerifier);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PresentationsPage()
                    )
                );
              },
            ),
          ],
        )
    );
  }
}