import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/apply_scenario/apply_scenario.dart';
import 'package:morpheus_sdk/inspector.dart';
import 'package:morpheus_sdk/io.dart';

class DataAvailableAlert extends StatelessWidget {
  final Scenario _scenario;
  final Map<String, SignedWitnessStatement> _processStatementMap;

  const DataAvailableAlert(this._scenario, this._processStatementMap, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      Row(children:[Expanded(child: Icon(Icons.check_circle,size: 48,color: Theme.of(context).primaryColor))]),
      Row(children:[Expanded(child:
      Container(
          margin: EdgeInsets.only(top:16, bottom:16),
          child: Text('You have all the data available.',textAlign: TextAlign.center)
      )
      )]),
      FlatButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ApplyScenarioPage(
                    _scenario,
                    _processStatementMap,
                  )
              )
          );
        },
        child: Text(
          "APPLY",
          style: TextStyle(fontSize: 14.0),
        ),
      )
    ]);
  }
}