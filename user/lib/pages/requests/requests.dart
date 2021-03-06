import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/pages/requests/request_info.dart';
import 'package:morpheus_kyc_user/pages/requests/requests_list_view.dart';
import 'package:morpheus_kyc_user/shared_prefs.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:morpheus_kyc_user/store/store.dart';
import 'package:morpheus_sdk/authority.dart';
import 'package:morpheus_sdk/utils.dart';

class RequestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RequestsPageState();
  }
}

class RequestsPageState extends State<RequestsPage> {
  Future<List<RequestInfo>> _fut;
  final Log _log = Log(RequestsPageState);

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
            ? RequestsListView(snapshot.data.where((element) => element != null).toList())
            : Center(child: CircularProgressIndicator()),
      );
    },
  );

  Future<List<RequestInfo>> _futureBuilder() async {
    _log.debug('Building requests future...');
    final store = await AppStore.getInstance();
    return await Future.wait(store.state.requests.requests.map((sentRequest) => _requestFuture(sentRequest)));
  }

  Future<RequestInfo> _requestFuture(SentRequest sentRequest) async {
    try {
      final status = await AuthorityPublicApi(await AppSharedPrefs.getAuthorityUrl()).getRequestStatus(sentRequest.capabilityLink);
      return RequestInfo(status.data, sentRequest);
    }
    catch(e) {
      return null;
    }
  }
}