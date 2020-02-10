import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/core/requests.dart';

class RequestIcon {
  static Icon byStatus(BuildContext context, RequestStatus status) {
    switch(status) {
      case RequestStatus.APPROVED:
        return Icon(Icons.done, color: Theme.of(context).primaryColor);
        break;
      case RequestStatus.REJECTED:
        return Icon(Icons.block, color: Colors.red,);
        break;
      case RequestStatus.PENDING:
        return Icon(Icons.sync, color: Colors.deepOrange,);
        break;
      default:
        throw Exception('Invalid status: $status');
    }
  }
}