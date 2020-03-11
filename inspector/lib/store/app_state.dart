import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/io.dart';

part 'app_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AppState {
  final String url;
  final String presentationJson;
  final SignedPresentation presentation;
  final List<String> errors;
  final List<String> warnings;
  final int discount;

  const AppState({
    @required this.url,
    @required this.presentationJson,
    @required this.presentation,
    @required this.errors,
    @required this.warnings,
    @required this.discount,
  });

  @override
  int get hashCode =>
      url.hashCode ^ presentationJson.hashCode ^ presentation.hashCode ^ errors.hashCode ^ warnings.hashCode ^ discount.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            url == other.url &&
            presentationJson == other.presentationJson &&
            presentation == other.presentation &&
            errors == other.errors &&
            warnings == other.warnings &&
            discount == other.discount;
  }

  static AppState initialState() => AppState(
    url: null,
    presentationJson: null,
    presentation: null,
    errors: null,
    warnings: null,
    discount: null,
  );

  static AppState fromJson(dynamic json) => json == null ? initialState() : _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
