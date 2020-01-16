import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/available_processes/available_processes.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

//import 'package:morpheus_kyc_user/scan_qr.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String selectedDid='did:morpheus:ezFoo1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Morpheus')),
      body: Center(child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Welcome to Morpheus!', style: TextStyle(
                fontSize: 24
            )),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text('This application is for users described in the KYC use case.'),
            )
          ],
        )
      ),
      drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(children: [
                  const Text('Banking Profile',style: TextStyle(color: primaryColor,fontSize: 24)),
                ]),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [DropdownButton<String>(
                    value: selectedDid,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down,color: Colors.black),
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        selectedDid = newValue;
                      });
                    },
                    items: ['did:morpheus:ezFoo1', 'did:morpheus:ezFoo2']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )]
                )
              ]
            )
          ),
          ListTile(
            leading: const Icon(Icons.content_paste),
            title: const Text('Query Processes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListAvailableProcessesPage()
                  )
              );
            },
          ),
        ],
      )),
    );
  }
}
