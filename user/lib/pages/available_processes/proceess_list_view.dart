import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/process_details/process_details.dart';
import 'package:morpheus_sdk/authority.dart';

class ProcessListView extends StatelessWidget {
  final Map<String, Process> _processes;

  const ProcessListView(
    this._processes,
    {Key key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _buildItems(context);

    return Container(
      child: ListView.builder(
        itemCount: _processes.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (_, index) => items[index]
      ),
    );
  }

  List<Column> _buildItems(context) {
    List<Column> columns = [];
    for(final entry in _processes.entries) {
      final process = entry.value;
      final processContentId = entry.key;
      columns.add(Column(
        children: <Widget>[
          Divider(height: 5.0),
          ListTile(
            title: Text('${process.name}'),
            subtitle: Text('${process.description}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProcessDetailsPage(
                        processContentId,
                        process,
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
