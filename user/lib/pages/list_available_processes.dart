import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/components/witnessrequest/proceess_list_view.dart';
import 'package:morpheus_kyc_user/io/process_response.dart';
import 'package:morpheus_kyc_user/io/url_fetcher.dart';

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAvailableProcessesPageState();
  }
}

class ListAvailableProcessesPageState
    extends State<ListAvailableProcessesPage> {
  Future<ProcessResponse> _processesFuture;

  @override
  void initState() {
    super.initState();
    _processesFuture = UrlFetcher.fetch(
            'http://10.0.2.2:8080/morpheus/witness-service/processes/list')
        .then((respJson) {
      return ProcessResponse.fromJson(json.decode(respJson));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _processesFuture,
      builder: (BuildContext context, AsyncSnapshot<ProcessResponse> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Available Processes'),
            ),
            body: snapshot.hasData
                ? ProcessListView(processes: snapshot.data.processes)
                : Center(child: CircularProgressIndicator()));
      },
    );
  }
}
