import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_common/io/api/authority/content.dart';
import 'package:morpheus_common/io/api/authority/processes.dart';
import 'package:morpheus_kyc_user/pages/create_witness_request/create_witness_request.dart';

class ProcessDetailsPage extends StatefulWidget {
  final String _processContentId;
  final Process _process;

  const ProcessDetailsPage(
    this._processContentId,
    this._process,
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
    _fetchClaimSchemaFut = ContentResolver.resolve(widget._process.claimSchema);
    _fetchEvidenceSchemaFut = ContentResolver.resolve(widget._process.evidenceSchema);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_fetchClaimSchemaFut, _fetchEvidenceSchemaFut]).then(
        (responses) => ResolvedSchemas(responses[0], responses[1]),
      ),
      builder: (
          BuildContext context,
          AsyncSnapshot<ResolvedSchemas> snapshot
      ) {
        final subheadStyle = Theme.of(context).textTheme.subtitle1;
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
                      _buildClaimPanel(snapshot),
                      _buildEvidencePanel(snapshot),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: _buildButton(snapshot)
        );
      },
    );
  }

  FloatingActionButton _buildButton(AsyncSnapshot<ResolvedSchemas> snapshot) {
    Function onButtonPressed;
    String buttonLabel = 'Loading...';
    Widget buttonIcon = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(backgroundColor: Colors.white),
    );

    if (snapshot.hasData) {
      final claimSchema = JsonSchema.createSchema(snapshot.data.claimSchema);
      final evidenceSchema = JsonSchema.createSchema(snapshot.data.evidenceSchema);

      onButtonPressed = (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateWitnessRequest(
                    widget._processContentId,
                    widget._process.name,
                    claimSchema,
                    evidenceSchema,
                )
            )
        );
      };
      buttonLabel = 'Create Witness Request';
      buttonIcon = Icon(Icons.assignment);
    }

    return FloatingActionButton.extended(
      label: Text(buttonLabel),
      icon: buttonIcon,
      onPressed: onButtonPressed,
    );
  }

  ExpansionPanel _buildClaimPanel(AsyncSnapshot<ResolvedSchemas> snapshot) {
    List<Widget> claimDetails = <Widget>[];
    String title = 'Loading...';

    if(snapshot.hasData){
      final claimSchema = JsonSchema.createSchema(snapshot.data.claimSchema);
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

      title = 'Required Personal Information';
    }

    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
        body: Column(children: claimDetails),
        isExpanded: _detailsInfoState[0]
    );
  }

  ExpansionPanel _buildEvidencePanel(AsyncSnapshot<ResolvedSchemas> snapshot){
    List<Widget> evidenceDetails = <Widget>[];
    String title = 'Loading...';

    if(snapshot.hasData) {
      final evidenceSchema = JsonSchema.createSchema(snapshot.data.evidenceSchema);
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
      title = 'Required Evidence';
    }

    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
        body: Column(children: evidenceDetails),
        isExpanded: _detailsInfoState[1]
    );
  }
}

class ResolvedSchemas {
  final String claimSchema;
  final String evidenceSchema;

  ResolvedSchemas(this.claimSchema, this.evidenceSchema);
}
