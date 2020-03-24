import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/io.dart';

part 'presentations_state.g.dart';

@JsonSerializable(explicitToJson: true)
class PresentationsState {
  final List<CreatedPresentation> presentations;

  PresentationsState(this.presentations);

  PresentationsState copy() => PresentationsState(List.from(presentations));

  void add(CreatedPresentation presentation) => presentations.add(presentation);

  factory PresentationsState.fromJson(Map<String, dynamic> json) => _$PresentationsStateFromJson(json);

  Map<String, dynamic> toJson() => _$PresentationsStateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatedPresentation {
  final SignedPresentation presentation;
  final Map<String,dynamic> dataToBeShared;
  final String scenarioName;
  final DateTime createdAt;
  final String url;

  CreatedPresentation(this.presentation, this.dataToBeShared, this.scenarioName, this.createdAt, this.url);

  factory CreatedPresentation.fromJson(Map<String, dynamic> json) => _$CreatedPresentationFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedPresentationToJson(this);
}