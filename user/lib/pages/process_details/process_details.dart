import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/io/api/authority/authority-api.dart';
import 'package:morpheus_kyc_user/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/pages/create_claim_data/provide_claim_data.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

class ProcessDetailsPage extends StatefulWidget {
  final Process _process;
  final AuthorityApi _authorityApi;

  const ProcessDetailsPage(
    this._process,
    this._authorityApi,
    {Key key}
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProcessDetailsPageState();
  }
}

class ProcessDetailsPageState extends State<ProcessDetailsPage> {
  Future<String> _fetchClaimSchemaFut;
  Future<String> _fetchEvidenceSchemaFut;
  Map<int, bool> _detailsInfoState = {
    0: false,
    1: false,
  };
  bool claimSchemaDetailsOpen;
  bool evidenceSchemaDetailsOpen;

  ProcessDetailsPageState();

  @override
  void initState() {
    super.initState();
    _fetchClaimSchemaFut = widget._authorityApi.getBlob(widget._process.claimSchema);
    _fetchEvidenceSchemaFut = widget._authorityApi.getBlob(widget._process.evidenceSchema);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_fetchClaimSchemaFut, _fetchEvidenceSchemaFut]).then(
        (responses) => ProcessDetailsResponses(responses[0], responses[1]),
      ),
      builder: (
          BuildContext context,
          AsyncSnapshot<ProcessDetailsResponses> snapshot
      ) {
        List<Widget> claimDetails = <Widget>[];
        List<Widget> evidenceDetails = <Widget>[];

        Function onButtonPressed;
        String buttonLabel = 'Loading...';
        Widget buttonIcon = SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(backgroundColor: Colors.white),
        );

        if (snapshot.hasData) {
          final claimSchema = JsonSchema.createSchema(snapshot.data.claimSchemaResponse);
          final evidenceSchema = JsonSchema.createSchema(snapshot.data.evidenceSchameResponse);

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


          onButtonPressed = (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProvideClaimDataPage(
                        widget._process.name, claimSchema, evidenceSchema
                    )
                )
            );
          };
          buttonLabel = 'Create Witness Request';
          buttonIcon = Icon(Icons.assignment);
        }

        final subheadStyle = Theme.of(context).textTheme.subhead;
        final captionStyle = Theme.of(context).textTheme.caption;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget._process.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 16.0, right: 16.0),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[Text('Description', style: subheadStyle)],),
                      Row(children: <Widget>[Expanded(child: Text(widget._process.description, style: captionStyle,))]),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 16.0, right: 16.0),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[Text('Version', style: subheadStyle)]),
                      Row(children: <Widget>[Expanded(child: Text(widget._process.version.toString(), style: captionStyle))]),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: ExpansionPanelList(
                    expansionCallback: (index, isExpanded) {
                      setState(() {
                        _detailsInfoState[index] = !isExpanded;
                        _detailsInfoState[(index - 1).abs()] = false; // yes, hacky. Closes the other one
                      });
                    },
                    children: <ExpansionPanel>[
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) => ListTile(title: const Text('Required Personal Information')),
                          body: Column(children: claimDetails),
                          isExpanded: _detailsInfoState[0]
                      ),
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) => ListTile(title: const Text('Required Evidence')),
                          body: Column(children: evidenceDetails),
                          isExpanded: _detailsInfoState[1]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              label: Text(buttonLabel),
              icon: buttonIcon,
              backgroundColor: primaryMaterialColor,
              onPressed: onButtonPressed,
          ),
        );
      },
    );
  }
}

class ProcessDetailsResponses {
  final String claimSchemaResponse;
  final String evidenceSchameResponse;

  ProcessDetailsResponses(this.claimSchemaResponse, this.evidenceSchameResponse);
}
