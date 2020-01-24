import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:redux/redux.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAvailableProcessesPageState();
  }
}

class ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => store.state.authorityApi,
      builder: (_, AuthorityApi api) => FutureBuilder(
        future: api.getProcesses(),
        builder: (BuildContext context, AsyncSnapshot<List<Process>> snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Available Processes'),
              ),
              body: snapshot.hasData
                  ? ProcessListView(snapshot.data, api)
                  : Center(child: CircularProgressIndicator())
          );
        },
      ),
    );
  }
}
