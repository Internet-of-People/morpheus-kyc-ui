import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';
import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/io/qrcode_response.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAvailableProcessesPageState();
  }
}

class ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  AuthorityApi authorityApi;

  @override
  void initState() {
    super.initState();

    final api = QRCodeResponse('http://10.0.2.2:8080'); // TODO it's coming from a QR read
    authorityApi = AuthorityApi(api.apiUrl); // TODO can we not pass around this one?
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authorityApi.getProcesses(),
      builder: (BuildContext context, AsyncSnapshot<List<Process>> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Available Processes'),
            ),
            body: snapshot.hasData
                ? ProcessListView(snapshot.data, authorityApi)
                : Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
