import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/authority/content.dart';
import 'package:morpheus_common/io/api/authority/processes.dart';
import 'package:morpheus_kyc_user/pages/available_processes/proceess_list_view.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAvailableProcessesPageState();
  }
}

class ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  Future<Map<String, Process>> _processesFut;


  @override
  void initState() {
    super.initState();
    _processesFut = AuthorityApi.instance
        .getProcesses()
        .then((processesResp) async {
          final contentResolvers = _createContentResolverFutures(processesResp);
          final contents = await Future.wait(contentResolvers);

          Map<String, String> contentIdContentMap = Map();
          for(int i=0;i<contents.length;i++) {
            contentIdContentMap[processesResp.processes[i]] = contents[i];
          }
          return contentIdContentMap;
        })
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

  List<Future<String>> _createContentResolverFutures(ProcessResponse response) {
    List<Future<String>> futures = [];
    response.processes.forEach((contentId) {
      futures.add(ContentResolver.resolve(contentId));
    });

    return futures;
  }
}
