import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:morpheus_kyc_user/pages/requests/request_info.dart';

class RequestsListView extends StatelessWidget {
  final List<RequestInfo> _requests;

  const RequestsListView(this._requests, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(_requests.length == 0) {
      return Center(child: Text('No Requests Yet'),);
    }

    return Container(
      child: ListView.builder(
          itemCount: _requests.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (_, index) {
            final request = _requests[index];

            return Column(children: <Widget>[
              Divider(height: 5.0),
              Row(children: <Widget>[
                Padding(
                  child: RequestIcon.byStatus(context, request.status.status),
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                ),
                Expanded(child: ListTile(
                  title: Text('${request.request.processName}'),
                  subtitle: Text('${request.request.sentAt.toIso8601String()}'),
                ))
              ]),
            ]);
          }
      ),
    );
  }
}