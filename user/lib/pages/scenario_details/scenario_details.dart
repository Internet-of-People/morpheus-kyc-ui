import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/content_resolver.dart';
import 'package:morpheus_common/sdk/inspector_public_api.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_common/widgets/nullable_text.dart';
import 'package:morpheus_kyc_user/pages/scenario_details/data_available.dart';
import 'package:morpheus_kyc_user/pages/scenario_details/no_data_available.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:redux/redux.dart';

class ScenarioDetailsPage extends StatefulWidget {
  final Scenario _scenario;

  const ScenarioDetailsPage(this._scenario, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScenarioDetailsPageState();
}

class _ScenarioDetailsPageState extends State<ScenarioDetailsPage> {
  int _activePanel;
  Future<Map<String, Process>> _processesFut;
  Future<String> _resultSchemaFut;

  @override
  void initState() {
    super.initState();
    _processesFut = _resolveProcesses();
    _resultSchemaFut = ContentResolver.resolve(widget._scenario.resultSchema, ContentLocation.INSPECTOR_PUBLIC);
  }

  @override
  Widget build(BuildContext context) {
    final subheadStyle = Theme.of(context).textTheme.subtitle1;
    final captionStyle = Theme.of(context).textTheme.caption;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._scenario.name),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 16.0, right: 16.0),
            child: Column(children: [
              Row(children: <Widget>[Text('Description', style: subheadStyle)],),
              Row(children: <Widget>[Expanded(child: NullableText(text: widget._scenario.description, style: captionStyle))]),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 16.0, right: 16.0),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[Text('Version', style: subheadStyle)]),
                Row(children: <Widget>[Expanded(child: Text(widget._scenario.version.toString(), style: captionStyle))]),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() => _activePanel = isExpanded ? null : index);
              },
              children: [
                _buildPrerequisitesPanel(widget._scenario.prerequisites),
                _buildRequiredLicensesPanel(widget._scenario.requiredLicenses),
                _buildResultPanel(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: StoreConnector(
              converter: (Store<AppState> store) => store.state.requests.requests,
              builder: (context, List<SentRequest> sentRequests) {
                return FutureBuilder(
                  future: _buildStatusFutures(
                      sentRequests,
                      widget._scenario.prerequisites
                  ),
                  builder: (_,AsyncSnapshot<Map<String, SignedWitnessStatement>> snapshot) {
                    if(snapshot.hasData){
                      bool prerequisitesMeet = _checkPrerequisites(snapshot.data);
                      return prerequisitesMeet
                          ? DataAvailableAlert(widget._scenario, snapshot.data)
                          : NoDataAvailableAlert();
                    }
                    else {
                      return CircularProgressIndicator();
                    }
                  },
                );
              },
            )
          )
        ]),
      ),
    );
  }

  ExpansionPanel _buildPrerequisitesPanel(List<Prerequisite> prerequisites) {
    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => const ListTile(
            title: Text('Prerequisites'),
            subtitle: Text('What data you must provide?'),
        ),
        body: FutureBuilder(
          future: _processesFut,
          builder: (_, AsyncSnapshot<Map<String,Process>> snapshot) {
            List<Widget> details = [];
            if(snapshot.hasData) {
              prerequisites.forEach((p) {
                details.add(ListTile(
                  title: Text('Process: ${snapshot.data[p.process].name}'),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(p.claimFields.map((e) => '- $e').join('\n')),
                  )
                ));
              });
            }
            else {
              details.add(const Text('Loading...'));
            }

            return Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(children: details),
            );
          },
        ),
        isExpanded: _activePanel == _Panel.prerequisites.index
    );
  }

  ExpansionPanel _buildRequiredLicensesPanel(List<License> licenses) {
    List<Widget> details = licenses.map((l) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [Expanded(
          child: ListTile(
            title: Text('Issued To: ${l.issuedTo}'),
            subtitle: Text('Purpose: ${l.purpose}, expiry: ${l.expiry}'),
            isThreeLine: true,
          ),
        )],
      );
    }).toList();

    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => const ListTile(
          title: Text('Required Licenses'),
          subtitle: Text('Who will access to your data?'),
        ),
        body: Column(children: details),
        isExpanded: _activePanel == _Panel.requiredLicenses.index
    );
  }

  ExpansionPanel _buildResultPanel() {
    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => const ListTile(
          title: Text('Result'),
          subtitle: Text('What will you get?'),
        ),
        body: FutureBuilder(
          future: _resultSchemaFut,
          builder: (context, snapshot) {
            List<Widget> details = [];

            if(snapshot.hasData) {
              JsonSchema schema = JsonSchema.createSchema(snapshot.data);
              schema.properties.forEach((key, value) {
                details.add(ListTile(
                  title: Text(key),
                  subtitle: Text(value.description),
                  isThreeLine: true,
                ));
              });
            }
            else {
              details.add(const Text('Loading...'));
            }

            return Column(children: details);
          },
        ),
        isExpanded: _activePanel == _Panel.result.index
    );
  }

  Future<Map<String,Process>>_resolveProcesses() async {
    final ids = widget._scenario.prerequisites.map((e) => e.process).toList();
    final map = Map<String,Process>();
    final processes = await ContentResolver.resolveByContentIds(ids, ContentLocation.AUTHORITY_PUBLIC);
    processes.forEach((key, value) => map[key] = Process.fromJson(json.decode(value)));
    return map;
  }

  Future<Map<String,SignedWitnessStatement>> _buildStatusFutures(
      List<SentRequest> sentRequests,
      List<Prerequisite> prerequisites
  ) async {
    final List<String> expectedProcessIds = prerequisites.map((e) => e.process).toList();
    final Map<String,SignedWitnessStatement> completedProcesses = Map();

    await Future.wait(sentRequests.where((r) => expectedProcessIds.contains(r.processId)).map((r) async {
      final res = await AuthorityPublicApi.instance.getRequestStatus(r.capabilityLink);
      if(res.status == RequestStatus.approved) {
        completedProcesses[r.processId] = res.signedStatement;
      }
    }));

    return completedProcesses;
  }

  bool _checkPrerequisites(Map<String, SignedWitnessStatement> completedProcesses) {
    for (final p in widget._scenario.prerequisites) {
      if(!completedProcesses.containsKey(p.process)){
        return false;
      }
    }

    return true;
  }
}

enum _Panel {
  prerequisites,
  requiredLicenses,
  result,
}

extension _PanelExt on _Panel {
  int get index {
    switch(this) {
      case _Panel.prerequisites:
        return 0;
      case _Panel.requiredLicenses:
        return 1;
      case _Panel.result:
        return 2;
      default:
        throw Exception('Invalid Panel $this');
    }
  }
}