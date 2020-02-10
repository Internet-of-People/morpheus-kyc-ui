import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/io/api/authority/content.dart';

part 'processes.g.dart';

@JsonSerializable()
class ProcessResponse {
  final List<String> processes;

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

  Process(
    this.name,
    this.version,
    this.description,
    this.claimSchema,
    this.evidenceSchema,
    this.constraintsSchema,
  );

  Content get claimSchemaContent => Content.parse(this.claimSchema);

  Content get evidenceSchemaContent => Content.parse(this.evidenceSchema);

  Content get constraintsSchemaContent => Content.parse(this.constraintsSchema);

  factory Process.fromJson(Map<String, dynamic> json) =>
      _$ProcessFromJson(json);
}
