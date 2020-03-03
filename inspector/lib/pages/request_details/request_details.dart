import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:morpheus_common/io/api/core/requests.dart';
import 'package:morpheus_common/utils/schema_form/map_as_table.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:morpheus_inspector/pages/requests/request_info.dart';

class RequestDetailsPage extends StatelessWidget {
  final RequestInfo _info;

  const RequestDetailsPage(this._info, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> sections = [
      _buildStatusSection(context, _info.status.status),
      _buildMetaSection(),
    ];

    if(_info.status.status == RequestStatus.approved) {
      sections.add(_buildStatementSection());
    }

    return Scaffold(
      appBar: AppBar(title: Text('${_info.request.processName}')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: sections),
        ),
      ),
    );
  }

  Widget _buildMetaSection() {
    return Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: MapAsTable(_info.request.toJson(),'Meta')
    );
  }

  Widget _buildStatusSection(context, RequestStatus _status) {
    List<Widget> infos = [];

    infos.add(Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: RequestIcon.byStatus(context, _status),
      ),
      Expanded(child: Text('${toBeginningOfSentenceCase(describeEnum(_status))}',style: Theme.of(context).textTheme.subtitle1,)),
    ]));

    if(_status == RequestStatus.rejected && _info.status.rejectionReason != null) {
      infos.add(Row(children: [
        Padding(child: Text('Reason: ${_info.status.rejectionReason}'), padding: EdgeInsets.only(top:16.0))
      ]));
    }

    return Card(child: Container(
      padding: EdgeInsets.all(16.0),
      child: Column(children: infos),
    ));
  }

  Widget _buildStatementSection() {
    return Card(child: Container(
      padding: EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
      child: MapAsTable(_info.status.signedStatement.toJson(),'Statement'),
    ));
  }
}