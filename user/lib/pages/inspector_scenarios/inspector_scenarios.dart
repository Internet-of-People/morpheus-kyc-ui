import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/inspector_scenarios/scenarios_list_view.dart';
import 'package:morpheus_kyc_user/shared_prefs.dart';
import 'package:morpheus_sdk/inspector.dart';
import 'package:morpheus_sdk/utils.dart';

class InspectorScenariosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InspectorScenariosPageState();
}

class _InspectorScenariosPageState extends State<InspectorScenariosPage> {
  Future<Map<String, Scenario>> _scenariosFut;

  @override
  void initState() {
    super.initState();
    _scenariosFut = _createScenariosFut();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Map<String, Scenario>>(
    future: _scenariosFut,
    builder: (BuildContext context, AsyncSnapshot<Map<String, Scenario>> snapshot) {
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

  Future<Map<String,Scenario>> _createScenariosFut() async {
    final inspectorApi = InspectorPublicApi(await AppSharedPrefs.getInspectorUrl());
    final scenariosResp = await inspectorApi.listScenarios();
    final resolver = ContentResolver((contentId) async => (await inspectorApi.getPublicBlob(contentId)).data);
    final contents = await resolver.resolveByContentIds(scenariosResp.data.scenarios);
    return contents.map((contentId, content) => MapEntry(contentId, Scenario.fromJson(json.decode(content))));
  }
}