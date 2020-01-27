import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optional/optional.dart';

class MapAsTable extends StatelessWidget {
  final Map<String, dynamic> _map;
  final String _title;

  const MapAsTable(this._map, this._title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final table = _buildTable(_title, _map, true, context);
    if(table.isPresent) {
      return Column(children: [table.value]);
    }

    return Text('NO DATA PROVIDED');
  }

  Optional<Widget> _buildTable(String title, dynamic data, bool topLevel, BuildContext context) {
    if(data == null) {
      return Optional.empty();
    }

    if(topLevel) {
      final List<DataColumn> columns = const [DataColumn(label: Text('Key')), DataColumn(label: Text('Value'))];
      final List<DataRow> rows = _mapToRow(data, null);

      return Optional.of(Container(
        margin: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
        child: Column(
          children: <Widget>[
            Row(children: [Expanded(child: Text(toBeginningOfSentenceCase(title), style: Theme.of(context).textTheme.subhead,))]),
            Row(children: [Expanded(child: DataTable(
              columns: columns,
              rows: rows,
            ))])
          ],
        ),
      ));
    }

    return Optional.empty();
  }

  List<DataRow> _mapToRow(Map<String, dynamic> map, String parent){
    final List<DataRow> rows = [];

    for(final entry in map.entries) {
      final List<DataCell> cells = [];

      if(entry.value is Map) {
        rows.addAll(_mapToRow(entry.value as Map, entry.key));
      }
      else {
        cells.add(DataCell(Text(parent == null ? entry.key : '$parent / ${entry.key}')));

        // TODO currently we expect photo values' keys to be started with 'photo'
        // TODO we also expect that photos are base64 encoded
        if(entry.key.startsWith('photo')) {
          cells.add(DataCell(entry.value == null ? Text('null') : Image.memory(base64Decode(entry.value))));
        }
        else {
          cells.add(DataCell(Text(entry.value == null ? 'null' : entry.value)));
        }

        rows.add(DataRow(cells: cells));
      }
    }

    return rows;
  }
}