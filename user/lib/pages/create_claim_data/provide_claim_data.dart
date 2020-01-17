import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/pages/create_evidence_data/create_evidence_data.dart';

class ProvideClaimDataPage extends StatefulWidget{
  final String _processName;
  final JsonSchema _claimSchema;
  final JsonSchema _evidenceSchema;

  const ProvideClaimDataPage(
    this._processName,
    this._claimSchema,
    this._evidenceSchema,
    {Key key}
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProvideClaimDataPageState();
  }
}

class ProvideClaimDataPageState extends State<ProvideClaimDataPage> {
  DateTime _dateOfBirth;
  final _formKey = GlobalKey<FormState>();

  ProvideClaimDataPageState();

  void onContinueButtonPressed(){
    //print(widget._claimSchema.validateWithErrors({}));
    if(!_formKey.currentState.validate()){
      return;
    }
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreateEvidenceDataPage(widget._processName)
    ));
  }

  void onDateTapped() async {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._processName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Continue',
            onPressed: onContinueButtonPressed
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Claim Data', style: Theme.of(context).textTheme.headline),
                Card(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text('Address', style: Theme.of(context).textTheme.subhead),
                        TextFormField(
                          onEditingComplete: () => _formKey.currentState.validate(),
                          onChanged: (_) => _formKey.currentState.validate(),
                          decoration: const InputDecoration(
                              hintText: 'Eg. Berlin, Germany',
                          ),
                          validator: RequiredValidator(errorText: 'Required'),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text('Place of Birth', style: Theme.of(context).textTheme.subhead),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Eg. Germany',
                              labelText: 'Country'
                          ),
                          onEditingComplete: ()=>_formKey.currentState.validate(),
                          onChanged: (_) => _formKey.currentState.validate(),
                          validator: RequiredValidator(errorText: 'Required'),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Eg. Berlin',
                              labelText: 'City'
                          ),
                          onEditingComplete: ()=>_formKey.currentState.validate(),
                          onChanged: (_) => _formKey.currentState.validate(),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Required'),
                            MinLengthValidator(2, errorText: 'Min length is 2'),
                            MaxLengthValidator(50, errorText: 'Max length is 50')
                          ]),
                        ),
                      ],
                    ),
                  )
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: onDateTapped,
                          child: Container(
                            margin: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Text('Date of Birth', style: Theme.of(context).textTheme.subhead),
                                Text(
                                  _dateOfBirth == null ? 'Please Select' : DateFormat.yMd().format(_dateOfBirth),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}