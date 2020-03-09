import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/content_resolver.dart';
import 'package:morpheus_common/sdk/inspector_public_api.dart';
import 'package:morpheus_kyc_user/pages/inspector_scenarios/scenarios_list_view.dart';

class InspectorScenariosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InspectorScenariosPageState();
}

class _InspectorScenariosPageState extends State<InspectorScenariosPage> {
  Future<Map<String, Scenario>> _scenariosFut;

  @override
  void initState() {
    super.initState();
    _scenariosFut = InspectorPublicApi.instance
        .listScenarios()
        .then((resp) => ContentResolver.resolveByContentIds(resp.scenarios, ContentLocation.INSPECTOR_PUBLIC))
        .then((contents) => contents.map(
            (contentId, content) => MapEntry(contentId, Scenario.fromJson(json.decode(content)))
        ));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Map<String, Scenario>>(
    future: _scenariosFut,
    builder: (BuildContext context, AsyncSnapshot<Map<String, Scenario>> snapshot) {
      print(snapshot.error);
      return Scaffold(
          appBar: AppBar(
            title: const Text('Available Scenarios'),
          ),
          body: snapshot.hasData
              ? ScenariosListView(snapshot.data)
              : Center(child: CircularProgressIndicator())
      );
    },
  );

}