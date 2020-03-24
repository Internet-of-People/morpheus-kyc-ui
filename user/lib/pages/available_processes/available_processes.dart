import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';
import 'package:morpheus_kyc_user/shared_prefs.dart';
import 'package:morpheus_sdk/authority.dart';
import 'package:morpheus_sdk/utils.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListAvailableProcessesPageState();
}

class _ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  Future<Map<String, Process>> _processesFut;

  @override
  void initState() {
    super.initState();
    _processesFut = _createProcessesFut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Process>>(
      future: _processesFut,
      builder: (BuildContext context, AsyncSnapshot<Map<String, Process>> snapshot) {
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

  Future<Map<String, Process>> _createProcessesFut() async {
    final processesResp = await AuthorityPublicApi(await AppSharedPrefs.getAuthorityUrl()).listProcesses();
    final resolver = ContentResolver((contentId) async => (await AuthorityPublicApi(await AppSharedPrefs.getAuthorityUrl()).getPublicBlob(contentId)).data);
    final contents = await resolver.resolveByContentIds(processesResp.data.processes);
    return contents.map((contentId, content) => MapEntry(contentId, Process.fromJson(json.decode(content))));
  }
}
