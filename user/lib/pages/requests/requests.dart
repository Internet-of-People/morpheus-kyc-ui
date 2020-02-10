import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_kyc_user/pages/requests/requests_list_view.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:redux/redux.dart';

class RequestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestsPageState();
  }
}

class RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) => StoreConnector(
    converter: (Store<AppState> store) => store.state.requests.requests,
    builder: (_, List<SentRequest> requests) => FutureBuilder<List<RequestStatusResponse>>(
      future: Future.wait( // TODO: mapping must contain sentrequest's data to be able to show it
          requests.map((sentRequest) => AuthorityApi.instance.checkRequestStatus(sentRequest.capabilityLink))
      ),
      builder: (context, AsyncSnapshot<List<RequestStatusResponse>> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Requests'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    // TODO
                  },
                ),
              ],
            ),
            body: snapshot.hasData
                ? RequestsListView()
                : Center(child: CircularProgressIndicator()),
        );
      },
    )
  );
}