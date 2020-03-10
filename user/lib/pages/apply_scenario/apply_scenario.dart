import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_common/sdk/inspector_public_api.dart';
import 'package:morpheus_common/sdk/io.dart';

class ApplyScenarioPage extends StatefulWidget {
  final Scenario _scenario;
  final Map<String, SignedWitnessStatement> _processStatementMap;

  const ApplyScenarioPage(this._scenario, this._processStatementMap, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplyScenarioPageState();
}

class _ApplyScenarioPageState extends State<ApplyScenarioPage> {
  @override
  Widget build(BuildContext context) {
    final subheadStyle = Theme.of(context).textTheme.subtitle1;

    widget._scenario.prerequisites.forEach((p) {
      final statement = widget._processStatementMap[p.process];
      JsonSchema schema = JsonSchema.createSchema(statement.content.claim.content);
      print(statement.content.claim.content);
      p.claimFields.forEach((f) {
        // TODO: this one does only return object schemas
        // we have to write a custom resolver
        print(schema.resolvePath('#/address'));
      });
    });


    return Scaffold(
      appBar: AppBar(
        title: Text(widget._scenario.name),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 16.0, right: 16.0),
            child: Column(children:[
              Row(children:[Expanded(child: Icon(Icons.description,size: 48,color: Theme.of(context).primaryColor))]),
              Row(children:[Expanded(child:
                Container(
                    margin: EdgeInsets.only(top:16),
                    child: Text('Please confirm!',textAlign: TextAlign.center, style: subheadStyle,)
                )
              )])
            ]),
          )
        ]),
      ),
    );
  }
}