import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/inspector_public_api.dart';

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
      final scenarioContentId = entry.key;
      columns.add(Column(
        children: <Widget>[
          Divider(height: 5.0),
          ListTile(
            title: Text('${scenario.name}'),
            subtitle: Text('${scenario.description}'),
            onTap: () {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProcessDetailsPage(
                        processContentId,
                        scenario,
                      )
                  )
              );*/
            },
          ),
        ],
      ));
    }
    return columns;
  }
}