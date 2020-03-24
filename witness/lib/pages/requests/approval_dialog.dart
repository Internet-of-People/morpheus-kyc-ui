import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:morpheus_common/widgets/key_selector.dart';
import 'package:morpheus_sdk/authority.dart';
import 'package:morpheus_sdk/io.dart';
import 'package:morpheus_sdk/utils.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:witness/app_model.dart';
import 'package:witness/shared_prefs.dart';
import 'package:witness/store/state/app_state.dart';

class ApproveResult {
  final SignedWitnessStatement statement;

  ApproveResult(this.statement);
}

class ApprovalDialog extends StatefulWidget {
  final String capabilityLink;
  final String processId;
  final Claim claim;

  const ApprovalDialog(
    this.capabilityLink,
    this.processId,
    this.claim,
    {Key key}
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApprovalDialogDialogState();
}

class _ApprovalDialogDialogState extends State<ApprovalDialog> {
  bool _approving = false;
  KeySelectorController _keySelectorController = KeySelectorController();

  @override
  Widget build(BuildContext context) {
    List<Widget> actionButtons = [];
    if(_approving){
      actionButtons.add(SizedBox(
        child: Padding(child: CircularProgressIndicator(), padding: EdgeInsets.all(16.0)),
        width: 48,
        height: 48,
      ));
    }
    else {
      actionButtons.addAll([
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop(ApproveResult(null));
          },
        ),
        StoreConnector(
          converter: (Store<AppState> store) => store.state.activeDid,
          builder: (_, activeDid) => FlatButton(
            child: Text('APPROVE'),
            textColor: Colors.red,
            onPressed: () async {
              setState(() {
                _approving = true;
              });

              final selectedKey = _keySelectorController.value;

              final now = DateTime.now();
              final constraints = WitnessStatementConstraints(
                  now,
                  DateTime(now.year +1, now.month, now.day),
                  '$activeDid#${selectedKey.keyIndex}',
                  activeDid,
                  null
              );
              final statement = WitnessStatement(
                  widget.claim,
                  widget.processId,
                  constraints,
                  nonce264()
              );

              final signedStatement = Provider.of<AppModel>(context, listen: false).cryptoAPI.signWitnessStatement(
                  json.encode(statement.toJson()),
                  selectedKey.key
              );

              await AuthorityPrivateApi(await AppSharedPrefs.getAuthorityUrl()).approveRequest(
                  widget.capabilityLink,
                  signedStatement
              );

              setState(() {
                _approving = false;
              });

              Navigator.of(context).pop(ApproveResult(signedStatement));
            },
          ),
        )
      ]);
    }

    return AlertDialog(
      title: const Text('Signing'),
      content: SingleChildScrollView(
        child: ListBody(children: [
          KeySelector(_keySelectorController, Provider.of<AppModel>(context, listen: false).cryptoAPI)
        ]),
      ),
      actions: actionButtons,
    );
  }
}