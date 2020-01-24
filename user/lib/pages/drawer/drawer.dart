import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/drawer/header.dart';
import 'package:morpheus_kyc_user/pages/scan_qr/scan_qr.dart';
import 'package:morpheus_kyc_user/sdk/api.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:redux/redux.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainDrawerState();
  }
}

class MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listDids(),
      builder: (context,snapshot){
        bool menusEnabled = false;
        List<String> dids;

        if(snapshot.hasData) {
          menusEnabled = true;
          dids = snapshot.data;
        }

        return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Header(dids),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Scan Authority Info'),
                  enabled: menusEnabled,
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
                StoreConnector(
                  converter: (Store<AppState> store) => (String apiUrl) => store.dispatch(SetAuthorityApiUrlAction(apiUrl)),
                  builder: (_, setAuthorityApiUrl) => ListTile(
                      leading: const Icon(Icons.android),
                      title: const Text('Local Debug'),
                      enabled: menusEnabled,
                      onTap: () {
                        setAuthorityApiUrl('http://10.0.2.2:8080');
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListAvailableProcessesPage()
                            )
                        );
                      },
                    )
                ),
              ],
            )
        );
      },
    );
  }
}