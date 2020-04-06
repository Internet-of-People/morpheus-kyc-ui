import 'package:flutter/material.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:morpheus_kyc_user/pages/request_details/request_details.dart';
import 'package:morpheus_kyc_user/pages/requests/request_info.dart';

class RequestsListView extends StatelessWidget {
  final List<RequestInfo> _requests;

  const RequestsListView(this._requests, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(_requests.isEmpty) {
      return Center(child: Text('No Requests Yet'),);
    }

    return Container(
      child: ListView.builder(
          itemCount: _requests.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (_, index) {
            final request = _requests[index];
            return Column(
              children: [
                Divider(height: 5.0),
                Row(children: <Widget>[
                  Padding(
                    child: RequestIcon.byStatus(context, request.status.status),
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                  ),
                  Expanded(child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestDetailsPage(request)
                        )
                      );
                    },
                    title: Text('${request.request.processName}'),
                    subtitle: Text('${request.request.sentAt.toIso8601String()}'),
                  ))
                ]),
              ],
            );
          }
      ),
    );
  }
}