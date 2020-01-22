import 'package:flutter/material.dart';
import 'package:morpheus_kyc_user/utils/morpheus_color.dart';

class Header extends StatefulWidget{
  final List<String> dids;

  const Header(this.dids, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeaderState();
  }
}

class HeaderState extends State<Header> {
  String selectedDid;

  @override
  Widget build(BuildContext context) {
    List<Widget> header = [
      Expanded(child: const Text('Your Profile',style: TextStyle(color: Colors.white,fontSize: 24)))
    ];

    if(widget.dids == null) {
      header.add(SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ));
    }

    return DrawerHeader(
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        margin: EdgeInsets.zero,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(children: header),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildDidsDropdown()
              )
            ]
        )
    );
  }

  List<Widget> _buildDidsDropdown() {
    if(widget.dids != null) {
      if(selectedDid==null) {
        selectedDid = widget.dids[0];
      }

      return [Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        margin: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: DropdownButton<String>(
          value: selectedDid,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black),
          style: TextStyle(color: Colors.black),
          underline: Container(height: 0),
          onChanged: (String newValue) {
            setState(() {
              selectedDid = newValue;
            });
          },
          items: widget.dids.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      )];
    }

    return [];
  }
}