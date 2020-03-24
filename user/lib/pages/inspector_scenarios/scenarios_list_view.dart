import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/scenario_details/scenario_details.dart';
import 'package:morpheus_sdk/inspector.dart';

class ScenariosListView extends StatelessWidget {
  final Map<String, Scenario> _scenarios;

  const ScenariosListView(this._scenarios, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _buildItems(context);

    return Container(
      child: ListView.builder(
          itemCount: _scenarios.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (_, index) => items[index]
      ),
    );
  }

  List<Column> _buildItems(context) {
    List<Column> columns = [];
    for(final entry in _scenarios.entries) {
      final scenario = entry.value;
      columns.add(Column(
        children: <Widget>[
          Divider(height: 5.0),
          ListTile(
            title: Text('${scenario.name}'),
            subtitle: Text('${scenario.description}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScenarioDetailsPage(
                        scenario,
                      )
                  )
              );
            },
          ),
        ],
      ));
    }
    return columns;
  }
}