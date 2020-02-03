import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/native_sdk.dart';
import 'package:witness/pages/requests.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Header(NativeSDK.instance.listDids()),
            ListTile(
              leading: const Icon(Icons.android),
              title: const Text('Requests - Emulator'),
              onTap: () {
                AuthorityApi.setAsEmulator();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestsPage()
                    )
                );
              },
            )
          ],
        )
    );
  }
}