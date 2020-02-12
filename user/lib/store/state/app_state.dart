import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';

part 'app_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AppState {
  final String activeDid;
  final RequestsState requests;

  AppState({
    @required this.activeDid,
    @required this.requests,
  });

  @override
  int get hashCode =>
      activeDid.hashCode ^ requests.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            activeDid == other.activeDid &&
            requests == other.requests;
  }

  static AppState initialState() => AppState(
    activeDid: null,
    requests: RequestsState([])
  );

  static AppState fromJson(dynamic json) => json == null ? initialState() : _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
