import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';

class RequestDetailsPage extends StatefulWidget {
  final WitnessRequestWithMetaData _request;

  RequestDetailsPage(this._request);

  @override
  State<StatefulWidget> createState() {
    return RequestDetailsPageState();
  }
}

class RequestDetailsPageState extends State<RequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Witness')),
      body: Text('TBD')
    );
  }
}