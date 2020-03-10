import 'package:flutter/material.dart';

class NoDataAvailableAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children:[
      Row(children:[Expanded(child: Icon(Icons.warning,size: 48,color: Colors.deepOrange,))]),
      Row(children:[Expanded(child:
        Container(
            margin: EdgeInsets.only(top:16),
            child: Text('Currently you don\'t have the data described in the prerequisites. Visit one of the authorities\' service to get the required data.',textAlign: TextAlign.center)
        )
      )])
    ]);
  }
}