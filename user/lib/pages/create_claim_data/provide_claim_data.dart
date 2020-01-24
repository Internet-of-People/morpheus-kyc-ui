import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/pages/create_evidence_data/create_evidence_data.dart';
import 'package:morpheus_kyc_user/utils/form_builder.dart';

class ProvideClaimDataPage extends StatefulWidget{
  final String _processName;
  final JsonSchema _claimSchema;
  final JsonSchema _evidenceSchema;

  ProvideClaimDataPage(
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  void onContinueButtonPressed(){
    if(!_formKey.currentState.validate()){
      setState(() {
        _autovalidate = true;
      });
      return;
    }

    _formKey.currentState.save();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreateEvidenceDataPage(widget._processName, widget._evidenceSchema)
    ));
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
          child: Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: SchemaDefinedFormContent(
                widget._claimSchema,
                'Claim Data'
            ),
          )
        ),
      )
    );
  }
}