import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/pages/create_evidence_data/create_evidence_data.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:morpheus_kyc_user/utils/schema_form/form_builder.dart';
import 'package:redux/redux.dart';

// TODO: save the state somehow when user comes back from the evidence page
// it's by default saved by currentState.save() but as we create new TextEditingController
// in the form_builder, the values get lost as the state is recreated (I guess).
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
  final JsonSchemaFormTree _schemaTree = JsonSchemaFormTree();
  bool _autovalidate = false;

  void onContinueButtonPressed(void Function(Map<String, dynamic>) setClaimData){
    if(!_formKey.currentState.validate()){
      setState(() {
        _autovalidate = true;
      });
      return;
    }

    print(_schemaTree.asMapWithValues());
    setClaimData(_schemaTree.asMapWithValues());
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
          StoreConnector(
            converter: (Store<AppState> store) => (Map<String, dynamic> claimData) => store.dispatch(
                SetWitnessRequestClaimDataAction(claimData)
            ),
            builder: (_,setClaimData) => IconButton(
                icon: const Icon(Icons.arrow_forward),
                tooltip: 'Continue',
                onPressed: () => onContinueButtonPressed(setClaimData)
            ),
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
                'Claim Data',
                _schemaTree
            ),
          )
        ),
      )
    );
  }
}