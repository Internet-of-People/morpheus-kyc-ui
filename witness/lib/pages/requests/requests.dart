import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_common/io/api/core/processes.dart';
import 'package:morpheus_common/io/api/core/requests.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:witness/drawer/drawer.dart';
import 'package:witness/pages/requests/request_collected_info.dart';
import 'package:witness/pages/requests/request_details.dart';

class RequestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestsPageState();
  }
}

class RequestsPageState extends State<RequestsPage> {
  Future<List<RequestCollectedInfo>> _fut;

  @override
  void initState() {
    _fut = _futureBuilder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Requests'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _fut = _futureBuilder();
            });
          },
        ),
      ],
    ),
    drawer: MainDrawer(),
    body: FutureBuilder<List<RequestCollectedInfo>>(
      future: _fut,
      builder: (context, AsyncSnapshot<List<RequestCollectedInfo>> snapshot) {
        return snapshot.hasData
            ? _buildList(snapshot.data, snapshot.connectionState != ConnectionState.done)
            : Center(child: CircularProgressIndicator());
      },
    ),
  );

  Widget _buildList(List<RequestCollectedInfo> requests, bool loading) {
    final List<Widget> children = [];

    if(loading) {
      children.add(LinearProgressIndicator());
    }
    else {
      children.add(Padding(padding: EdgeInsets.only(top:6)));
    }

    children.add(ListView.builder(
        shrinkWrap: true,
        itemCount: requests.length,
        itemBuilder:(context, int index) {
          RequestCollectedInfo request = requests[index];
          return Column(
            children: <Widget>[
              Divider(height: 5.0),
              _buildRequestRow(request)
            ],
          );
        }
    ));

    return Column(children: children);
  }

  Widget _buildRequestRow(RequestCollectedInfo info) {
    return Row(children: <Widget>[
      Padding(
        child: RequestIcon.byStatus(context, info.status),
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
      ),
      Expanded(child: ListTile(
        title: Text(info.process.name),
        subtitle: Text(info.dateOfRequest.toIso8601String()),
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RequestDetailsPage(info)
              )
          );
          setState(() {
            _fut = _futureBuilder();
          });
        },
      ))
    ]);
  }

  Future<List<RequestCollectedInfo>> _futureBuilder() async {
    final List<RequestCollectedInfo> _requests = List();
    final Map<String, Process> _processMap = Map();

    final response = await AuthorityApi.instance.getWitnessRequests();
    final processIds = response.requests.map((r) => r.processId).toSet();

    await Future.forEach(processIds, (id) async {
      final process = Process.fromJson(json.decode(await AuthorityApi.instance.getBlob(id)));
      _processMap[id] = process;
    });

    await Future.forEach(response.requests, (WitnessRequestStatus witnessRequestStatus) async {
      final request = SignedWitnessRequest.fromJson(
          json.decode(await AuthorityApi.instance.getPrivateBlob(witnessRequestStatus.requestId))
      );
      final requestStatus = await AuthorityApi.instance.checkRequestStatus(witnessRequestStatus.capabilityLink);
      final process = _processMap[witnessRequestStatus.processId];

      _requests.add(RequestCollectedInfo(
        capabilityLink: witnessRequestStatus.capabilityLink,
        process: process,
        dateOfRequest: witnessRequestStatus.dateOfRequest,
        notes: witnessRequestStatus.notes,
        request: request,
        status: witnessRequestStatus.status,
        rejectionReason: requestStatus.rejectionReason,
        statement: requestStatus.signedStatement,
      ));
    });

    return _requests;
  }
}
