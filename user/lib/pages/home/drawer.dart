import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/io/qrcode_response.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/pages/scan_qr/scan_qr.dart';
import 'package:morpheus_kyc_user/sdk/api.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainDrawerState();
  }
}

class MainDrawerState extends State<MainDrawer> {
  String selectedDid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listDids(),
      builder: (context,snapshot){
        bool menusEnabled = false;

        if(snapshot.hasData) {
          menusEnabled = true;
          print(snapshot.data);
        }

        return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    margin: EdgeInsets.zero,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(children: [
                            const Text('Your Profile',style: TextStyle(color: Colors.white,fontSize: 24)),
                          ]),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              children: buildDidsDropdown(snapshot)
                          )
                        ]
                    )
                ),
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
                ListTile(
                  leading: const Icon(Icons.android),
                  title: const Text('Local Debug'),
                  enabled: menusEnabled,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListAvailableProcessesPage(QRCodeResponse('http://10.0.2.2:8080'))
                        )
                    );
                  },
                ),
              ],
            )
        );
      },
    );
  }

  List<Widget> buildDidsDropdown(AsyncSnapshot<List<String>> snapshot) {
    if(snapshot.hasData) {
      if(selectedDid==null) {
        selectedDid = snapshot.data[0];
      }

      return [Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        margin: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(4.0)
        ),
        child: DropdownButton<String>(
          value: selectedDid,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black),
          style: TextStyle(color: Colors.black),
          underline: Container(height: 0),
          onChanged: (String newValue) {
            setState(() {
              selectedDid = newValue;
            });
          },
          items: snapshot.data.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      )];
    }

    return [CircularProgressIndicator(backgroundColor: Colors.white,)];
  }
}