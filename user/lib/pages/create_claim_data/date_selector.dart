import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final String _title;

  const DateSelector(this._title, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DateSelectorState();
  }
}

class DateSelectorState extends State<DateSelector> {
  DateTime _dateOfBirth;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onDateTapped,
      child: TextField(
        decoration: InputDecoration(
          labelText: widget._title,
          labelStyle: TextStyle(color: Theme.of(context).textTheme.caption.color)
        ),
        controller: _controller,
        enabled: false,
      ),
    );
  }

  void _onDateTapped() async {
    final lastDate = DateTime.now().subtract(Duration(days: 365*18));

    final picked = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth == null ? lastDate : _dateOfBirth,
        firstDate: DateTime(1920, 01, 01),
        lastDate: lastDate
    );

    if(picked != null) {
      setState(() {
        _dateOfBirth = picked;
        _controller.text = DateFormat.yMd().format(_dateOfBirth);
      });
    }
  }
}