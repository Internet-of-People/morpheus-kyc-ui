import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:json_schema/json_schema.dart';
import 'package:morpheus_common/io/api/authority/authority_api.dart';
import 'package:morpheus_common/io/api/authority/requests.dart';
import 'package:morpheus_common/io/api/core/requests.dart';
import 'package:morpheus_common/io/api/ledger/did.dart';
import 'package:morpheus_common/io/api/sdk/native_sdk.dart';
import 'package:morpheus_common/utils/nonce.dart';
import 'package:morpheus_common/utils/schema_form/form_builder.dart';
import 'package:morpheus_common/utils/schema_form/map_as_table.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/store/actions/actions.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';
import 'package:redux/redux.dart';

abstract class _Step {
  static const int claimSchema = 0;
  static const int evidenceSchema = 1;
  static const int selectKey = 2;
  static const int confirmAndSign = 3;
}

class CreateWitnessRequest extends StatefulWidget{
  final JsonSchemaFormTree _claimSchemaTree = JsonSchemaFormTree();
  final JsonSchemaFormTree _evidenceSchemaTree = JsonSchemaFormTree();
  final String _processName;
  final String _processContentId;
  final JsonSchema _claimSchema;
  final JsonSchema _evidenceSchema;

  CreateWitnessRequest(
    this._processName,
    this._processContentId,
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

  bool _claimFormAutoValidate = false;
  bool _evidenceFormAutoValidate = false;
  Map<String, dynamic> _claimData;
  Map<String, dynamic> _evidenceData;
  int _currentStep = _Step.claimSchema;
  List<StepState> _stepStates = [
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
  ];
  SchemaDefinedFormContent _claimForm;
  SchemaDefinedFormContent _evidenceForm;
  List<String> _availableKeys;
  String _selectedKey;
  int _selectedKeyIndex;
  bool _signing = false;

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

    _availableKeys = DIDDocument.fromJson(
        json.decode(NativeSDK.instance.getDocument(NativeSDK.instance.listDids()[0]))
    ).keys.map((key) => key.auth).toList();
    _selectedKeyIndex = 0;
    _selectedKey = _availableKeys[_selectedKeyIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._processName),
      ),
      body: Stepper(
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          controlsBuilder: _buildStepperNavigation,
          steps: [
            Step(
                title: const Text('Providing Personal Information'),
                isActive: _currentStep == _Step.claimSchema,
                state: _stepStates[_Step.claimSchema],
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _claimFormKey,
                      autovalidate: _claimFormAutoValidate,
                      child: _claimForm,
                    ),
                  ),
                )
            ),
            Step(
                title: const Text('Providing Evidence'),
                isActive: _currentStep == _Step.evidenceSchema,
                state: _stepStates[_Step.evidenceSchema],
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _evidenceFormKey,
                      autovalidate: _evidenceFormAutoValidate,
                      child: _evidenceForm,
                    ),
                  ),
                )
            ),
            Step(
                title: const Text('Select Key'),
                isActive: _currentStep == _Step.selectKey,
                state: _stepStates[_Step.selectKey],
                content: Column(
                  children: <Widget>[
                    Row(children: [
                      Expanded(child: Text(
                        'Please select, which key you would like to use for signing this request:',
                      ))
                    ]),
                    DropdownButton<String>(
                      value: _selectedKey,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down,color: Colors.black),
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedKeyIndex = _availableKeys.indexOf(newValue);
                          _selectedKey = _availableKeys[_selectedKeyIndex];
                        });
                      },
                      items: _availableKeys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                    ),
                  ],
                )
            ),
            Step(
                title: const Text('Confirm'),
                subtitle: const Text('Please confirm sign'),
                isActive: _currentStep == _Step.confirmAndSign,
                state: _stepStates[_Step.confirmAndSign],
                content: Column(
                  children: <Widget>[
                    MapAsTable(_claimData, 'Personal Information'),
                    MapAsTable(_evidenceData, 'Evidence'),
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
                  ],
                )
            ),
          ]
      )
    );
  }

  _onStepContinue() {
    if(_currentStep == _Step.claimSchema) {
      if (!_claimFormKey.currentState.validate()) {
        setState(() {
          _stepStates[_Step.claimSchema] = StepState.error;
          _claimFormAutoValidate = true;
        });
        return;
      }

      setState(() {
        _claimData = widget._claimSchemaTree.asMapWithValues();
        _stepStates[_Step.claimSchema] = StepState.complete;
        _currentStep++;
      });
    }
    else if(_currentStep == _Step.evidenceSchema) {
      if (!_evidenceFormKey.currentState.validate()) {
        setState(() {
          _stepStates[_Step.evidenceSchema] = StepState.error;
          _evidenceFormAutoValidate = true;
        });
        return;
      }

      setState(() {
        _evidenceData = widget._evidenceSchemaTree.asMapWithValues();
        _stepStates[_Step.evidenceSchema] = StepState.complete;
        _currentStep++;
      });
    }
    else if(_currentStep == _Step.selectKey){
      setState(() {
        _stepStates[_Step.selectKey] = StepState.complete;
        _currentStep++;
      });
    }
  }

  _onStepCancel() {
    if (_currentStep > _Step.claimSchema) {
      setState(() => _currentStep = _currentStep - 1);
    }
  }

  _onSign(SignButtonStoreContext storeContext) async {
    final claim = Claim(storeContext.activeDid, _claimData);

    final request = WitnessRequest(
      claim,
      '${storeContext.activeDid}#$_selectedKeyIndex',
      widget._processContentId,
      _evidenceData,
      nonce264(),
    );

    final sdkSignedRequest = NativeSDK.instance.signWitnessRequest(
        json.encode(request.toJson()),
        _selectedKey
    );

    setState(() {
      _signing = true;
    });

    final signedRequest = SignedWitnessRequest.fromJson(json.decode(sdkSignedRequest));
    await Future.delayed(Duration(seconds: 2));

    SendWitnessRequestResponse resp = await AuthorityApi.instance.sendWitnessRequest(signedRequest);
    storeContext.dispatch(SentRequest(
      widget._processName,
      DateTime.now(),
      AuthorityApi.instance.name,
      resp.capabilityLink,
    ));

    setState(() {
      _signing = false;
    });

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(children: <Widget>[
          Text('Sent')
        ],),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Your request has been sent.')
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('BACK TO HOME'),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder:(context) => HomePage()
                  ),
                  (route) => false
              );
            },
          ),
        ],
      )
    );
  }

  Widget _buildStepperNavigation(BuildContext context, { onStepCancel, onStepContinue }) {
    final ThemeData themeData = Theme.of(context);
    final cancelButton = Container(
      margin: const EdgeInsetsDirectional.only(start: 8.0),
      child: FlatButton(
        onPressed: onStepCancel,
        textColor: Colors.black54,
        textTheme: ButtonTextTheme.normal,
        child: Text('BACK'),
      ),
    );
    final continueButton = FlatButton(
      onPressed: onStepContinue,
      color: themeData.primaryColor,
      textColor: Colors.white,
      textTheme: ButtonTextTheme.normal,
      child: Text('CONTINUE'),
    );
    final signButton = StoreConnector(
      converter: (Store<AppState> store) => SignButtonStoreContext(
          store.state.activeDid,
          (sentRequest) => store.dispatch(AddRequestAction(sentRequest))
      ),
      builder: (_, SignButtonStoreContext storeContext) => FlatButton(
        onPressed: () => _onSign(storeContext),
        color: themeData.primaryColor,
        textColor: Colors.white,
        textTheme: ButtonTextTheme.normal,
        child: Text('SIGN & SEND'),
      ),
    );

    List<Widget> buttons = [];

    switch(_currentStep) {
      case _Step.claimSchema:
        buttons.add(continueButton);
        break;
      case _Step.evidenceSchema:
        buttons.add(continueButton);
        buttons.add(cancelButton);
        break;
      case _Step.selectKey:
        buttons.add(continueButton);
        buttons.add(cancelButton);
        break;
      case _Step.confirmAndSign:
        if(_signing){
          buttons.add(CircularProgressIndicator());
        }
        else {
          buttons.add(signButton);
          buttons.add(cancelButton);
        }
        break;
    }

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons
        ),
      ),
    );
  }
}

class SignButtonStoreContext {
  final String activeDid;
  final void Function(SentRequest sentRequest) dispatch;

  SignButtonStoreContext(this.activeDid, this.dispatch);
}