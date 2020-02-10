import 'package:json_annotation/json_annotation.dart';

part 'processes.g.dart';

@JsonSerializable(explicitToJson: true)
class ProcessResponse {
  final List<String> processes;

  ProcessResponse(this.processes);

  factory ProcessResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcessResponseFromJson(json);
}