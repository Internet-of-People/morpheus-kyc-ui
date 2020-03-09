import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/content_resolver.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListAvailableProcessesPageState();
}

class _ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  Future<Map<String, Process>> _processesFut;

  @override
  void initState() {
    super.initState();
    _processesFut = AuthorityPublicApi.instance
        .listProcesses()
        .then((resp) => ContentResolver.resolveByContentIds(resp.processes, ContentLocation.AUTHORITY_PUBLIC))
        .then((contents) => contents.map(
            (contentId, content) => MapEntry(contentId, Process.fromJson(json.decode(content)))
        ));
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
}
