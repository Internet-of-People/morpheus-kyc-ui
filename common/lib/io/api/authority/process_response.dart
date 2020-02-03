import 'package:json_annotation/json_annotation.dart';

part 'process_response.g.dart';

@JsonSerializable()
class ProcessResponse {
  final List<Process> processes;

  ProcessResponse(this.processes);

  factory ProcessResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcessResponseFromJson(json);
}

@JsonSerializable()
class Process {
  final String name;
  final int version;
  final String description;
  final String claimSchema;
  final String evidenceSchema;
  final String constraintsSchema;

  Process(this.name, this.version, this.description, this.claimSchema,
      this.evidenceSchema, this.constraintsSchema);

  factory Process.fromJson(Map<String, dynamic> json) =>
      _$ProcessFromJson(json);
}
