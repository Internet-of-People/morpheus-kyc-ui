import 'package:flutter/material.dart';
import 'package:morpheus_common/io/api/core/processes.dart';
import 'package:morpheus_common/io/api/core/requests.dart';

class RequestCollectedInfo {
  final RequestStatus status;
  final String capabilityLink;
  final String rejectionReason;
  final String notes;
  final DateTime dateOfRequest;
  final Process process;
  final SignedWitnessRequest request;
  final SignedStatement statement;

  RequestCollectedInfo({
    @required this.status,
    @required this.capabilityLink,
    @required this.rejectionReason,
    @required this.notes,
    @required this.dateOfRequest,
    @required this.process,
    @required this.request,
    @required this.statement,
  });
}