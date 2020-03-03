import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AppState {
  final String url;
  final String presentationJson;
  final List<String> signatureErrors;
  final int discount;

  AppState({
    this.url,
    this.presentationJson,
    this.signatureErrors,
    this.discount,
  });

  @override
  int get hashCode =>
      url.hashCode ^ presentationJson.hashCode ^ signatureErrors.hashCode ^ discount.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            url == other.url &&
            presentationJson == other.presentationJson &&
            signatureErrors == other.signatureErrors &&
            discount == other.discount;
  }

  static AppState initialState() => AppState();

  static AppState fromJson(dynamic json) => json == null ? initialState() : _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
