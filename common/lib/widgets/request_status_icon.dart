import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/io.dart';

class RequestIcon {
  static Icon byStatus(BuildContext context, RequestStatus status) {
    switch(status) {
      case RequestStatus.approved:
        return Icon(Icons.done, color: Theme.of(context).primaryColor);
        break;
      case RequestStatus.rejected:
        return Icon(Icons.block, color: Colors.red,);
        break;
      case RequestStatus.pending:
        return Icon(Icons.inbox, color: Colors.deepOrange,);
        break;
      default:
        throw Exception('Invalid status: $status');
    }
  }
}