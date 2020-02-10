import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_kyc_user/pages/requests/request_info.dart';
import 'package:morpheus_kyc_user/pages/requests/requests_list_view.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:morpheus_kyc_user/store/store.dart';

class RequestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestsPageState();
  }
}

class RequestsPageState extends State<RequestsPage> {
  Future<List<RequestInfo>> _fut;

  @override
  void initState() {
    super.initState();
    _fut = _futureBuilder();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<RequestInfo>>(
    future: _fut,
    builder: (context, AsyncSnapshot<List<RequestInfo>> snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Requests'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _fut = _futureBuilder();
                });
              },
            ),
          ],
        ),
        body: snapshot.hasData
            ? RequestsListView(snapshot.data)
            : Center(child: CircularProgressIndicator()),
      );
    },
  );

  Future<List<RequestInfo>> _futureBuilder() {
    print('refresing');
    final store = storeInstance();
    return Future.wait(store.state.requests.requests.map((sentRequest) => _requestFuture(sentRequest)));
  }

  Future<RequestInfo> _requestFuture(SentRequest sentRequest) async {
    final status = await AuthorityApi.instance.checkRequestStatus(sentRequest.capabilityLink);
    return RequestInfo(status, sentRequest);
  }
}