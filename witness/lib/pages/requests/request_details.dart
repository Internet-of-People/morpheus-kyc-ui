import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:morpheus_common/io/api/core/requests.dart';
import 'package:morpheus_common/utils/schema_form/map_as_table.dart';
import 'package:morpheus_common/widgets/request_status_icon.dart';
import 'package:witness/pages/requests/approval_dialog.dart';
import 'package:witness/pages/requests/rejection_dialog.dart';
import 'package:witness/pages/requests/request_collected_info.dart';

class RequestDetailsPage extends StatefulWidget {
  final RequestCollectedInfo _info;

  RequestDetailsPage(this._info);

  @override
  State<StatefulWidget> createState() {
    return RequestDetailsPageState(this._info.status, this._info.rejectionReason, this._info.statement);
  }
}

class RequestDetailsPageState extends State<RequestDetailsPage> {
  RequestStatus _status;
  String _rejectionReason;
  SignedWitnessStatement _statement;

  RequestDetailsPageState(this._status, this._rejectionReason, this._statement);

  @override
  Widget build(BuildContext context) {
    List<Widget> sections = [
      _buildStatusSection(),
      _buildProcessSection(),
      _buildRequestMetaSection(),
      _buildRequestSection(),
    ];

    if(_status == RequestStatus.approved) {
      sections.add(_buildStatementSection());
    }

    Widget floatingActionButton;
    if(_status == RequestStatus.pending) {
      floatingActionButton = _buildFloatingActionButton();
    }

    return Scaffold(
      appBar: AppBar(title: Text('${widget._info.process.name}')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: sections),
        ),
      ),
      floatingActionButton: floatingActionButton
    );
  }

  Widget _buildFloatingActionButton() => SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 22.0),
    children: [
      SpeedDialChild(
          child: Icon(Icons.thumb_up),
          backgroundColor: Theme.of(context).primaryColor,
          label: 'Approve',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async {
            final approvalResult = await showDialog<ApproveResult>(
              context: context,
              barrierDismissible: false,
              builder: (_) => ApprovalDialog(
                widget._info.capabilityLink,
                widget._info.processId,
                widget._info.request.content.claim
              )
            );

            if(approvalResult.statement!=null) {
              setState(() {
                _statement = approvalResult.statement;
                _status = RequestStatus.approved;
              });
            }
          }
      ),
      SpeedDialChild(
          child: Icon(Icons.thumb_down),
          backgroundColor: Colors.red,
          label: 'Reject',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () async {
            final rejectionResult = await showDialog<RejectionResult>(
                context: context,
                barrierDismissible: false,
                builder: (_) => RejectionDialog(widget._info.capabilityLink)
            );
            if(rejectionResult.rejected) {
              setState(() {
                _status = RequestStatus.rejected;
                _rejectionReason = rejectionResult.rejectionReason;
              });
            }
          }
      ),
    ],
  );

  Widget _buildStatusSection() {
    List<Widget> infos = [];

    infos.add(Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: RequestIcon.byStatus(context, _status),
      ),
      Expanded(child: Text('${toBeginningOfSentenceCase(describeEnum(_status))}',style: Theme.of(context).textTheme.subtitle1,)),
    ]));

    if(_status == RequestStatus.rejected && _rejectionReason != null) {
      infos.add(Row(children: [
        Padding(child: Text('Reason: $_rejectionReason'), padding: EdgeInsets.only(top:16.0))
      ]));
    }

    return Card(child: Container(
      padding: EdgeInsets.all(16.0),
      child: Column(children: infos),
    ),);
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

  Widget _buildRequestMetaSection() {
    Map<String, dynamic> infos = Map();
    infos['Claimant'] = widget._info.request.content.claimant;
    infos['DateOfRequest'] = widget._info.dateOfRequest;
    if(widget._info.notes!=null) {
      infos['Notes'] = widget._info.notes;
    }

    return Column(children: [
      Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: MapAsTable(infos,'Request Meta')
      )
    ]);
  }

  Widget _buildRequestSection() {
    final content = widget._info.request.content;

    return Column(children: [
      Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: MapAsTable(content.claim.content,'Claim')
      ),
      Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: MapAsTable(content.evidence,'Evidence')
      ),
    ]);
  }

  Widget _buildStatementSection() {
    return Card(child: Container(
      padding: EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
      child: MapAsTable(_statement.toJson(),'Statement'),
    ));
  }
}