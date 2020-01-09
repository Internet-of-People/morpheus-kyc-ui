import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:morpheus_kyc_user/components/witnessrequest/ProcessListView.dart';
import 'package:morpheus_kyc_user/io/process-response-dto.dart';
import 'dart:developer' as developer;

class ListAvailableProcessesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAvailableProcessesPageState();
  }
}

class ListAvailableProcessesPageState extends State<ListAvailableProcessesPage> {
  Future<ProcessResponseDTO> _processesFuture;


  @override
  void initState() {
    super.initState();
    _processesFuture = fetchProcesses();
  }

  Future<ProcessResponseDTO> fetchProcesses() async {
    developer.log('Fetching processes...');

    try {
      final response = await http.get('http://10.0.2.2:8080/morpheus/witness-service/processes/list');
      developer.log('Got response, status code: ${response.statusCode}');

      if(response.statusCode == 200) {
        return ProcessResponseDTO.fromJson(json.decode(response.body));
      }
      else {
        throw Exception('Failed to fetch processes. Status code: ${response.statusCode}');
      }
    }
    catch(e){
      throw Exception('Failed to fetch processes. Reason: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _processesFuture,
        builder: (BuildContext context, AsyncSnapshot<ProcessResponseDTO> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Available Processes'),
            ),
            body: snapshot.hasData
                ? ProcessListView(processes: snapshot.data.processes)
                : Center(child: CircularProgressIndicator())
          );
        },
    );
  }

}