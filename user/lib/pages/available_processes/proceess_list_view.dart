import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/process_response.dart';
import 'package:morpheus_kyc_user/pages/process_details/process_details.dart';

class ProcessListView extends StatelessWidget {
  final List<Process> _processes;

  const ProcessListView(
    this._processes,
    {Key key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _processes.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (BuildContext context, int index) {
          final process = _processes[index];
          return Column(
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
                            process,
                          )
                      )
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
