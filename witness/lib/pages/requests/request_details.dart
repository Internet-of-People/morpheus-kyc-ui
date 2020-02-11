import 'package:flutter/material.dart';
import 'package:witness/pages/requests/request_collected_info.dart';

class RequestDetailsPage extends StatefulWidget {
  final RequestCollectedInfo _info;

  RequestDetailsPage(this._info);

  @override
  State<StatefulWidget> createState() {
    return RequestDetailsPageState();
  }
}

class RequestDetailsPageState extends State<RequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget._info.process.name}')),
      body: Text('TBD')
    );
  }
}