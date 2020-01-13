import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:morpheus_kyc_user/io/process_response.dart';
import 'package:morpheus_kyc_user/io/url_fetcher.dart';
import 'package:json_schema/json_schema.dart';

class ProcessDetailsPage extends StatefulWidget {
  final Process process;

  const ProcessDetailsPage({Key key, @required this.process}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProcessDetailsPageState(this.process);
  }
}

class ProcessDetailsPageState extends State<ProcessDetailsPage> {
  Process _process;
  Future<String> _fetchClaimSchema;
  Future<String> _fetchEvidenceSchema;
  Map<int, bool> _detailsInfoState = {
    0: false,
    1: false,
  };
  bool claimSchemaDetailsOpen;
  bool evidenceSchemaDetailsOpen;

  ProcessDetailsPageState(this._process);

  @override
  void initState() {
    super.initState();
    _fetchClaimSchema =
        UrlFetcher.fetch(utf8.decode(base64.decode(_process.claimSchema)));
    _fetchEvidenceSchema =
        UrlFetcher.fetch(utf8.decode(base64.decode(_process.evidenceSchema)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_fetchClaimSchema, _fetchEvidenceSchema]).then(
        (responses) => ProcessDetailsResponses(responses[0], responses[1]),
      ),
      builder: (BuildContext context,
          AsyncSnapshot<ProcessDetailsResponses> snapshot) {
        List<Widget> claimDetails = <Widget>[];
        List<Widget> evidenceDetails = <Widget>[];

        if (snapshot.hasData) {
          final claimSchema =
              JsonSchema.createSchema(snapshot.data.claimSchemaResponse);
          final evidenceSchema =
              JsonSchema.createSchema(snapshot.data.evidenceSchameResponse);

          claimDetails = <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Description'),
                  subtitle: Text(claimSchema.description),
                )
              ],
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Required Data'),
                  subtitle: Text(claimSchema.requiredProperties.join(', ')),
                )
              ],
            )
          ];

          evidenceDetails = <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Description'),
                  subtitle: Text(evidenceSchema.description),
                )
              ],
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Required Data'),
                  subtitle: Text(evidenceSchema.requiredProperties.join(', ')),
                )
              ],
            )
          ];
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(_process.name),
            ),
            body: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text('Description'),
                    subtitle: Text(_process.description),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Version'),
                    subtitle: Text(_process.version.toString()),
                  ),
                ),
                ExpansionPanelList(
                  expansionCallback: (index, isExpanded) {
                    setState(() {
                      _detailsInfoState[index] = !isExpanded;
                      _detailsInfoState[(index - 1).abs()] =
                          false; // yes, hacky. Closes the other one
                    });
                  },
                  children: <ExpansionPanel>[
                    ExpansionPanel(
                        headerBuilder: (context, isExpanded) =>
                            ListTile(title: const Text('Claim Schema Details')),
                        body: Column(children: claimDetails),
                        isExpanded: _detailsInfoState[0]),
                    ExpansionPanel(
                        headerBuilder: (context, isExpanded) => ListTile(
                            title: const Text('Evidence Schema Details')),
                        body: Column(children: evidenceDetails),
                        isExpanded: _detailsInfoState[1]),
                  ],
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Create Witness Request'),
                      onPressed: null,
                    )
                  ],
                )
              ],
            ));
      },
    );
  }
}

class ProcessDetailsResponses {
  final String claimSchemaResponse;
  final String evidenceSchameResponse;

  ProcessDetailsResponses(
      this.claimSchemaResponse, this.evidenceSchameResponse);
}
