import 'package:flutter/material.dart';
import 'package:morpheus_common/sdk/authority_public_api.dart';
import 'package:morpheus_common/sdk/io.dart';

class RequestCollectedInfo {
  final RequestStatus status;
  final String capabilityLink;
  final String rejectionReason;
  final String notes;
  final DateTime dateOfRequest;
  final Process process;
  final String processId;
  final SignedWitnessRequest request;
  final SignedWitnessStatement statement;

  RequestCollectedInfo({
    @required this.status,
    @required this.capabilityLink,
    @required this.rejectionReason,
    @required this.notes,
    @required this.dateOfRequest,
    @required this.process,
    @required this.processId,
    @required this.request,
    @required this.statement,
  });
}