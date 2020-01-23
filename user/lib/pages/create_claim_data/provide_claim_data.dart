import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/pages/create_claim_data/form_builder.dart';
import 'package:morpheus_kyc_user/pages/create_evidence_data/create_evidence_data.dart';

// TODO save state if we navigate back the form is stilled filled out
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

  void onContinueButtonPressed(){
    /*if(!_formKey.currentState.validate()){ TODO
      return;
    }*/
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreateEvidenceDataPage(widget._processName, widget._evidenceSchema)
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
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Continue',
            onPressed: onContinueButtonPressed
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: SchemaDefinedForm(widget._claimSchema, 'Claim Data')
        ),
      )
    );
  }
}