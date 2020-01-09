import 'package:json_annotation/json_annotation.dart';

part 'process-response-dto.g.dart';

@JsonSerializable()
class ProcessResponseDTO {
  final List<ProcessDTO> processes;

  ProcessResponseDTO(this.processes);

  factory ProcessResponseDTO.fromJson(Map<String, dynamic> json) => _$ProcessResponseDTOFromJson(json);
}

@JsonSerializable()
class ProcessDTO {
  final String name;
  final String id;
  final int version;
  final String description;
  final String claimSchema;
  final String evidenceSchema;
  final String constraintsSchema;

  ProcessDTO(
    this.name,
    this.id,
    this.version,
    this.description,
    this.claimSchema,
    this.evidenceSchema,
    this.constraintsSchema
  );

  factory ProcessDTO.fromJson(Map<String, dynamic> json) => _$ProcessDTOFromJson(json);
}

