import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:morpheus_common/io/api/core/requests.dart';
import 'package:morpheus_common/utils/schema_form/map_as_table.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:witness/pages/requests/request_collected_info.dart';

class RequestDetailsPage extends StatefulWidget {
  final RequestCollectedInfo _info;

  RequestDetailsPage(this._info);

  @override
  State<StatefulWidget> createState() {
    return RequestDetailsPageState(this._info.status.status);
  }
}

class RequestDetailsPageState extends State<RequestDetailsPage> {
  RequestStatus _status;
  String _rejectionReason;

  RequestDetailsPageState(this._status);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget._info.process.name}')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            _buildStatusSection(),
            _buildProcessSection(),
            _buildRequestSection(),
            _buildStatementSection(),
          ]),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        children: [
          SpeedDialChild(
              child: Icon(Icons.thumb_up),
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Approve',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
          ),
          SpeedDialChild(
              child: Icon(Icons.thumb_down),
              backgroundColor: Colors.red,
              label: 'Reject',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
          ),
        ],
      )
    );
  }

  Widget _buildStatusSection() {
    List<Widget> infos = [];

    infos.add(Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: RequestIcon.byStatus(context, _status),
      ),
      Expanded(child: Text('${toBeginningOfSentenceCase(describeEnum(_status))}',style: Theme.of(context).textTheme.subtitle1,)),
    ]));

    if(_status == RequestStatus.rejected) {
      infos.add(Row(children: [
        Text('Reason: $_rejectionReason')
      ]));
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(children: infos),
    );
  }

  Widget _buildProcessSection() {
    final subheadStyle = Theme.of(context).textTheme.subtitle1;
    final process = widget._info.process;
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(children: [Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Process', style: subheadStyle),
            )]),
            Row(children: [Expanded(child: Text(process.description))]),
          ],
        ),
      ),
    ]);
  }

  Widget _buildRequestSection() {
    final request = widget._info.request;

    Map<String, dynamic> infos = Map();
    infos['DateOfRequest'] = request.dateOfRequest;
    infos['Notes'] = request.notes;

    return Column(children: [
      Container(
        margin: const EdgeInsets.all(16.0),
        child: MapAsTable(infos,'Request')
      )
    ]);
  }

  Widget _buildStatementSection() {
    return Card(child: Container(
      padding: EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
      child: MapAsTable(widget._info.status.signedStatement.toJson(),'Statement'),
    ));
  }
}