import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';

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
      return Scaffold(
          appBar: AppBar(title: const Text('Witness')),
          body: snapshot.hasData
              ? _buildList(snapshot.data.requests)
              : Center(child: CircularProgressIndicator())
      );
    },
  );

  Widget _buildList(List<WitnessRequestWithMetaData> requests) {
    return SingleChildScrollView(
      child: ListView.builder(
          itemCount: requests.length,
          itemBuilder:(context, int index) {
            WitnessRequestWithMetaData request = requests[index];
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(request.metadata.status.toString()),
                  subtitle: Text('TBD'),
                  onTap: () {
                  },
                ),
              ],
            );
          }
      ),
    );
  }
}