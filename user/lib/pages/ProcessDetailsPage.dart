import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/io/process-response-dto.dart';

class ProcessDetailsPage extends StatelessWidget {
  final ProcessDTO process;

  const ProcessDetailsPage({Key key, @required this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(process.name),
      ),
      body: Center(
        child: const Text('TODO'),
      ),
    );
  }
}