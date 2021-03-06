import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:json_resolve/json_resolve.dart';
import 'package:morpheus_common/utils/schema_form/map_as_table.dart';
import 'package:morpheus_common/widgets/key_selector.dart';
import 'package:morpheus_kyc_user/app_model.dart';
import 'package:morpheus_kyc_user/pages/home/home.dart';
import 'package:morpheus_kyc_user/shared_prefs.dart';
import 'package:morpheus_kyc_user/store/actions/actions.dart';
import 'package:morpheus_kyc_user/store/state/app_state.dart';
import 'package:morpheus_kyc_user/store/state/presentations_state.dart';
import 'package:morpheus_sdk/inspector.dart';
import 'package:morpheus_sdk/io.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class ApplyScenarioPage extends StatefulWidget {
  final Scenario _scenario;
  final Map<String, SignedWitnessStatement> _processStatementMap;

  const ApplyScenarioPage(this._scenario, this._processStatementMap, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplyScenarioPageState();
}

class _ApplyScenarioPageState extends State<ApplyScenarioPage> {
  final KeySelectorController _keySelectorController = KeySelectorController();

  @override
  Widget build(BuildContext context) {
    final dataToBeShared = _getDataThatWillBeShared();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._scenario.name),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(children:[
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child:Row(children: [Expanded(child: Text('Information', style: Theme.of(context).textTheme.subtitle1,))]),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child:Row(children: [Expanded(child: Text('You are about to create a Presentation here, which is a subset of your data that is enough to be shared to apply the scenario.'))]),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child:Row(children: [Expanded(child: Text('NOTE: Only the data shown below will be included in the Presentation with the sharing constraints defined by licenses.',style: Theme.of(context).textTheme.bodyText1))]),
              ),
              Divider(),
              MapAsTable(dataToBeShared, 'Data to be Shared'),
              Column(children: widget._scenario.requiredLicenses.map((l) => MapAsTable(l.toJson(), 'License')).toList()),
              Container(
                margin: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: KeySelector(_keySelectorController, Provider.of<AppModel>(context, listen: false).cryptoAPI),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32.0),
            child: StoreConnector(
              converter: (Store<AppState> store) => (presentation) => store.dispatch(AddPresentationAction(presentation)),
              builder: (_,storeDispatchFn) => FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                onPressed: () async => await _onCreatePresentationButtonPressed(storeDispatchFn, dataToBeShared),
                child: Text(
                  'CONFIRM & CREATE PRESENTATION',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Map<String, dynamic> _getDataThatWillBeShared() {
    final dataToBeShared = <String,dynamic>{};

    widget._scenario.prerequisites.forEach((prerequisite) {
      final statement = widget._processStatementMap[prerequisite.process];
      prerequisite.claimFields.forEach((field) {
        final f = field.startsWith('.') ? field.substring(1) : field;
        dataToBeShared[f]=resolve(json: statement.content.claim.content, path: f);
      });
    });

    return dataToBeShared;
  }

  Future<void> _onCreatePresentationButtonPressed (
    void Function(CreatedPresentation createdPresentation) storeDispatch,
    Map<String, dynamic> dataToBeShared,
  ) async {
    final cryptoAPI = Provider.of<AppModel>(context, listen: false).cryptoAPI;

    // IMPORTANT NOTE (to code analyzers): here, the SDK gives us the opportunity to send multiple
    // statements for one claim (meaning one claim can be signed via multiple authorities).
    // We can also send multiple claims as well.
    // In this PoC application though we only use one claim and one presentation.
    final provenClaims = widget._scenario.prerequisites.map((prerequisite){
      final signedWitnessStatement = widget._processStatementMap[prerequisite.process];
      final maskedClaimContent = cryptoAPI.maskJson(
          json.encode(signedWitnessStatement.content.claim.content),
          prerequisite.claimFields.join(',')
      );

      final collapsedClaim = json.decode(maskedClaimContent);
      final collapsedSignedWitnessStatement = signedWitnessStatement.toCollapsed(
        cryptoAPI.maskJson(
            json.encode(signedWitnessStatement.content.claim.toJson()),
            '',
        )
      );

      return ProvenClaim(
        Claim(signedWitnessStatement.content.claim.subject,collapsedClaim),
        [collapsedSignedWitnessStatement]
      );
    }).toList();

    // IMPORTANT NOTE (to code analyzers): currently we only pass the license that's
    // required by the scenario, but it's by default dynamic. Any kind of licenses can be passed here.
    final presentation = Presentation(
        provenClaims,
        widget._scenario.requiredLicenses.map((l) => _mapLicense(l)).toList()
    );
    final signedPresentation = cryptoAPI.signClaimPresentation(
        json.encode(presentation.toJson()),
        _keySelectorController.value.key,
    );

    final inspectorUrl = await AppSharedPrefs.getInspectorUrl();
    final inspectorResponse = await InspectorPublicApi(inspectorUrl).uploadPresentation(signedPresentation);
    final resp = inspectorResponse.data;
    final scenarioUrl = '$inspectorUrl/blob/${resp.contentId}';

    storeDispatch(CreatedPresentation(
      signedPresentation,
      dataToBeShared,
      widget._scenario.name,
      DateTime.now(),
      scenarioUrl,
    ));

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
                Text('Your presentation is now ready to use.')
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

  License _mapLicense(LicenseSpecification licenseSpecification) {
    final now = DateTime.now();
    return License(
      licenseSpecification.issuedTo,
      licenseSpecification.purpose,
      now,
      now.add(Duration(days: 1)), // TODO: convert the expiry field
    );
  }
}