import 'package:flutter/material.dart';
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
    return ProvideClaimDataPageState(_processName);
  }
}

class ProvideClaimDataPageState extends State<ProvideClaimDataPage> {
  final String _processName;
  DateTime _dateOfBirth;

  ProvideClaimDataPageState(this._processName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_processName),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Form(
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
                          decoration: const InputDecoration(
                              hintText: 'Eg. Berlin, Germany',
                          ),
                          validator: (value) {
                            return null;
                          },
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
                          validator: (value) {
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Eg. Berlin',
                              labelText: 'City'
                          ),
                          validator: (value) {
                            return null;
                          },
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
                          onTap: () async {
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
                          },
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CreateEvidenceDataPage()
                          ));
                        },
                        child: const Text(
                          'Continue'
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}