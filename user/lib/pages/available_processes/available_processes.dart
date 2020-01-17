import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';
import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/io/qrcode_response.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  final QRCodeResponse _qrCodeResponse;

  const ListAvailableProcessesPage(this._qrCodeResponse, {Key key}) : super(key: key);

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
    authorityApi = AuthorityApi(widget._qrCodeResponse.apiUrl); // TODO can we not pass around this one?
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
