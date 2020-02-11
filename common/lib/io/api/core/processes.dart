import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/io/api/core/content.dart';

part 'processes.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory Process.fromJson(Map<String, dynamic> json) => _$ProcessFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessToJson(this);
}