import 'package:flutter/material.dart';
import 'package:morpheus_sdk/authority.dart';
import 'package:witness/shared_prefs.dart';

class RejectionResult {
  bool rejected;
  String rejectionReason;

  RejectionResult(this.rejected, this.rejectionReason);
}

class RejectionDialog extends StatefulWidget {
  final String capabilityLink;

  const RejectionDialog(this.capabilityLink, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RejectionDialogState();
}

class _RejectionDialogState extends State<RejectionDialog> {
  bool _rejecting = false;
  final _rejectionReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rejectActionButtons = <Widget>[];
    if(_rejecting){
      rejectActionButtons.add(SizedBox(
        child: Padding(child: CircularProgressIndicator(), padding: EdgeInsets.all(16.0)),
        width: 48,
        height: 48,
      ));
    }
    else {
      rejectActionButtons.addAll([
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop(RejectionResult(
                false,
                null
            ));
          },
        ),
        FlatButton(
          child: Text('REJECT'),
          textColor: Colors.red,
          onPressed: () async {
            String rejectionReason;
            if(_rejectionReasonController.value.text.isNotEmpty) {
              rejectionReason = _rejectionReasonController.value.text;
            }

            setState(() {
              _rejecting = true;
            });

            await AuthorityPrivateApi(await AppSharedPrefs.getAuthorityUrl()).rejectRequest(
              widget.capabilityLink,
              rejectionReason
            );

            setState(() {
              _rejecting = false;
            });

            Navigator.of(context).pop(RejectionResult(
              true,
              rejectionReason
            ));
          },
        ),
      ]);
    }

    return AlertDialog(
      title: const Text('Are you sure?'),
      content: SingleChildScrollView(
        child: ListBody(children: [
          const Text('You are about to reject this request. This cannot be undone.'),
          TextFormField(
            enabled: !_rejecting,
            decoration: InputDecoration(
                labelText: 'Rejection Reason',
                hintText: 'Eg.: The given evidence is too blurry'
            ),
            controller: _rejectionReasonController,
          )
        ]),
      ),
      actions: rejectActionButtons,
    );
  }
}