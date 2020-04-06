import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final String _title;
  final FormFieldValidator _validator;
  final TextEditingController _controller;

  const DateSelector(this._title, this._validator, this._controller, {Key key}) : super(key: key);

  TextEditingController get controller => _controller;

  @override
  State<StatefulWidget> createState() {
    return DateSelectorState();
  }
}

class DateSelectorState extends State<DateSelector> {
  DateTime _dateOfBirth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onDateTapped,
      child: TextFormField(
        controller: widget._controller,
        decoration: InputDecoration(
          labelText: widget._title,
          labelStyle: TextStyle(color: Theme.of(context).textTheme.caption.color)
        ),
        validator: widget._validator,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode()); // don't show the keyboard
          _onDateTapped();
        },
      ),
    );
  }

  void _onDateTapped() async {
    final lastDate = DateTime.now().subtract(Duration(days: 365*18));

    final picked = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? lastDate,
        firstDate: DateTime(1920, 01, 01),
        lastDate: lastDate
    );

    if(picked != null) {
      setState(() {
        _dateOfBirth = picked;
        widget._controller.value = TextEditingValue(text: _format(_dateOfBirth));
      });
    }
  }

  String _format(DateTime date) => DateFormat('dd/MM/y').format(date);
}