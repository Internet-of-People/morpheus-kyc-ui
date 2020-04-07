import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:witness/app_model.dart';
import 'package:witness/drawer/header.dart';
import 'package:witness/pages/requests/requests.dart';
import 'package:witness/shared_prefs.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Header(Provider.of<AppModel>(context, listen: false).cryptoAPI.listDids()),
            ListTile(
              leading: const Icon(Icons.android),
              title: const Text('Requests'),
              onTap: () {
                AppSharedPrefs.setAuthorityUrl(TestUrls.gcpAuthority);
                AppSharedPrefs.setInspectorUrl(TestUrls.gcpInspector);
                AppSharedPrefs.setVerifierUrl(TestUrls.gcpVerifier);
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestsPage()
                    ),
                        (route) => false
                );
              },
            ),
          ],
        )
    );
  }
}