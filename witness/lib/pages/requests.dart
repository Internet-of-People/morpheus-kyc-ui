import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:witness/pages/request_details.dart';

class RequestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestsPageState();
  }
}

class RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) => FutureBuilder<WitnessRequestsResponse>(
    future: AuthorityApi.instance.getWitnessRequests(),
    builder: (context, AsyncSnapshot<WitnessRequestsResponse> snapshot) {
      print(snapshot.error);
      return Scaffold(
          appBar: AppBar(title: const Text('Witness')),
          body: snapshot.hasData
              ? _buildList(snapshot.data.requests)
              : Center(child: CircularProgressIndicator()),
      );
    },
  );

  Widget _buildList(List<WitnessRequestWithMetaData> requests) {
    return Container(
      child: ListView.builder(
          itemCount: requests.length,
          itemBuilder:(context, int index) {
            WitnessRequestWithMetaData request = requests[index];
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                _buildRequestRow(request)
              ],
            );
          }
      ),
    );
  }

  Widget _buildRequestRow(WitnessRequestWithMetaData request) {
    return Row(children: <Widget>[
      Padding(
        child: RequestIcon.byStatus(context, request.metadata.status),
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
      ),
      Expanded(child: ListTile(
        title: Text(request.metadata.status.toString()),
        subtitle: Text('TBD'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RequestDetailsPage(request)
              )
          );
        },
      ))
    ]);
  }
}