import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAvailableProcessesPageState();
  }
}

class ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthorityApi.instance.getProcesses(),
      builder: (BuildContext context, AsyncSnapshot<List<Process>> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Available Processes'),
            ),
            body: snapshot.hasData
                ? ProcessListView(snapshot.data)
                : Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
