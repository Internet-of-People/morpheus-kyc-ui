import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_kyc_user/store/actions.dart';
import 'package:morpheus_kyc_user/store/state.dart';
import 'package:morpheus_kyc_user/utils/schema_form/form_builder.dart';
import 'package:morpheus_kyc_user/utils/schema_form/map_as_table.dart';
import 'package:redux/redux.dart';

// TODO: save the state somehow when user comes back from the evidence page
// it's by default saved by currentState.save() but as we create new TextEditingController
// in the form_builder, the values get lost as the state is recreated (I guess).
class CreateWitnessRequest extends StatefulWidget{
  final String _processName;
  final JsonSchema _claimSchema;
  final JsonSchema _evidenceSchema;
  final JsonSchemaFormTree _claimSchemaTree = JsonSchemaFormTree();
  final JsonSchemaFormTree _evidenceSchemaTree = JsonSchemaFormTree();

  CreateWitnessRequest(
    this._processName,
    this._claimSchema,
    this._evidenceSchema,
    {Key key}
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateWitnessRequestState();
  }
}

class CreateWitnessRequestState extends State<CreateWitnessRequest> {
  final GlobalKey<FormState> _claimFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _evidenceFormKey = GlobalKey<FormState>();
  bool _claimFormAutovalidate = false;
  bool _evidenceFormAutovalidate = false;
  Map<String, dynamic> _claimData;
  Map<String, dynamic> _evidenceData;
  int _currentStep = 0;
  List<StepState> _stepStates = [
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
  ];
  SchemaDefinedFormContent _claimForm;
  SchemaDefinedFormContent _evidenceForm;

  @override
  void initState() {
    super.initState();

    _claimForm = SchemaDefinedFormContent(
        widget._claimSchema,
        widget._claimSchemaTree
    );

    _evidenceForm = SchemaDefinedFormContent(
        widget._evidenceSchema,
        widget._evidenceSchemaTree
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._processName),
      ),
      body: StoreConnector(
        converter: (Store<AppState> store) => _StepperStoreContext(store),
        builder: (_, _StepperStoreContext store) => Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if(_currentStep == 0) {
              if (!_claimFormKey.currentState.validate()) {
                setState(() {
                  _stepStates[0] = StepState.error;
                  _claimFormAutovalidate = true;
                });
                return;
              }

              setState(() {
                _claimData = widget._claimSchemaTree.asMapWithValues();
                _stepStates[0] = StepState.complete;
                _currentStep = 1;
              });
            }
            else if(_currentStep == 1) {
              if (!_evidenceFormKey.currentState.validate()) {
                setState(() {
                  _stepStates[1] = StepState.error;
                  _evidenceFormAutovalidate = true;
                });
                return;
              }

              setState(() {
                _evidenceData = widget._evidenceSchemaTree.asMapWithValues();
                _stepStates[1] = StepState.complete;
                _currentStep = 2;
              });
            }
            else if(_currentStep == 2){

            }
            else {

            }
          },
          onStepCancel: _onStepCancel,
          steps: [
            Step(
                title: const Text('Providing Personal Information'),
                isActive: _currentStep == 0,
                state: _stepStates[0],
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _claimFormKey,
                      autovalidate: _claimFormAutovalidate,
                      child: _claimForm,
                    ),
                  ),
                )
            ),
            Step(
                title: const Text('Providing Evidence'),
                isActive: _currentStep == 1,
                state: _stepStates[1],
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _evidenceFormKey,
                      autovalidate: _claimFormAutovalidate,
                      child: _evidenceForm,
                    ),
                  ),
                )
            ),
            Step(
                title: const Text('Confirm'),
                isActive: _currentStep == 2,
                state: _stepStates[2],
                content: Column(
                  children: <Widget>[
                    Card(child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: Row(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                          child: Icon(Icons.warning, color: Colors.deepOrange,),
                        ),
                        Expanded(child: Text(
                          'Are you sure, you would like to sign this data below and create a witness request?',
                        ))
                      ]),
                    )),
                    MapAsTable(_claimData, 'Personal Information'),
                    MapAsTable(_evidenceData, 'Evidence'),
                  ],
                )
            ),
            Step(
                title: const Text('Sign Witness Request'),
                isActive: _currentStep == 3,
                state: _stepStates[3],
                content: Text('?')
            )
          ]
        ),
      )
    );
  }

  _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep = _currentStep - 1);
    }
  }
}

class _StepperStoreContext {
  final Store<AppState> _store;

  _StepperStoreContext(this._store);

  void setClaimData(Map<String, dynamic> claimData) {
    _store.dispatch(
        SetWitnessRequestClaimDataAction(claimData)
    );
  }
}