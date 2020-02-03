import 'package:flutter/material.dart';

typedef OnDidSelected = void Function(String newValue);

class DidsSelectorContext {
  String activeDid;
  void Function(String newActiveDid) dispatch;

  DidsSelectorContext(this.activeDid, this.dispatch);

  void setActiveDid(String newActiveDid) {
    activeDid = newActiveDid;
    dispatch(newActiveDid);
  }
}

class DidsDropdown extends StatelessWidget {
  final List<String> _dids;
  final String _activeDid;
  final OnDidSelected _onChanged;

  const DidsDropdown(this._dids, this._activeDid, this._onChanged, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if(_dids != null) {
      children = [Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        margin: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: DropdownButton<String>(
          value: _activeDid,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black),
          style: TextStyle(color: Colors.black),
          underline: Container(height: 0),
          onChanged: _onChanged,
          items: _dids.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      )];
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children
    );
  }
}
