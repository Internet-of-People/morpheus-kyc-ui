import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/presentations_state.dart';
import 'package:redux/redux.dart';

class PresentationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Presentations'),
        ),
        body: Container(
          child: StoreConnector(
            converter: (Store<AppState> store) => store.state.presentations.presentations,
            builder: (_,List<CreatedPresentation> presentations) {
              if(presentations.isEmpty) {
                return Center(child: Text('No Presentations Yet'));
              }

              final items = _buildItems(context, presentations);
              return ListView.builder(
                  itemCount: presentations.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (_, index) => items[index]
              );
            }
          ),
        ),
    );
  }

  List<Column> _buildItems(BuildContext context, List<CreatedPresentation> presentations) {
    List<Column> columns = [];
    for(final presentation in presentations) {
      columns.add(Column(
        children: <Widget>[
          Divider(height: 5.0),
          ListTile(
            title: Text('${presentation.scenarioName}'),
            subtitle: Text('Created at: ${presentation.createdAt.toIso8601String()}'),
            onTap: () {
            },
          ),
        ],
      ));
    }
    return columns;
  }
}
