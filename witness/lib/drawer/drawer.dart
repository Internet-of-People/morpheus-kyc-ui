import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/sdk/native_sdk.dart';
import 'package:witness/drawer/header.dart';
import 'package:witness/pages/requests/requests.dart';

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
              title: const Text('Requests'),
              onTap: () {
                AuthorityApi.setAsRealDevice('http://34.76.108.115:8080');
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