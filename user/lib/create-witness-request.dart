import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:morpheus_kyc_user/io/process-response-dto.dart';
import 'package:morpheus_kyc_user/morpheus-color.dart';

class CreateWitnessRequestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateWitnessRequestPageState();
  }
}

class CreateWitnessRequestPageState extends State<CreateWitnessRequestPage> {
  ProcessResponseDTO _process; // TODO
  List<DropdownMenuItem<String>> _processes;

  Future<ProcessResponseDTO> fetchProcesses() async {
    final response = await http.get('http://127.0.0.1:8080/processes/list');

    if(response.statusCode == 200) {
      return ProcessResponseDTO.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to fetch processes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchProcesses(),
        builder: (BuildContext context, AsyncSnapshot<ProcessResponseDTO> processResponse) {
          if (processResponse.hasData) {
            _processes = processResponse.data.processes.map((ProcessDTO process){
              return DropdownMenuItem<String>(
                value: process.id,
                child: Text(process.name),
              );
            }).toList();
          }
          else if (processResponse.hasError) {
            // TODO
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Witness Request')
            ),
            body: Center(
              child: DropdownButton(
                disabledHint: Text('Fetching Services...'),
                value: 'One',
                icon: const Icon(Icons.arrow_downward),
                items: _processes,
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: PRIMARY_COLOR,
                ),
                onChanged: (String newValue) {
                  // TODO: redirect to the next page where he can see the details of the process
                  // TODO: shouldn't the process be a list instead? multirow maybe
                  /*setState(() {
                    dropdownValue = newValue;
                  });*/
                },
              ),
            ),
          );
        },
    );
  }

}