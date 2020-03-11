import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_kyc_user/store/state/presentations_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';

part 'app_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AppState {
  final String activeDid;
  final RequestsState requests;
  final PresentationsState presentations;

  AppState({
    @required this.activeDid,
    @required this.requests,
    @required this.presentations,
  });

  @override
  int get hashCode =>
      activeDid.hashCode ^ requests.hashCode ^ presentations.hashCode;

  @override
  bool operator == (other) {
    return identical(this, other) ||
        other is AppState &&
            activeDid == other.activeDid &&
            presentations == other.presentations &&
            requests == other.requests;
  }

  static AppState initialState() => AppState(
    activeDid: null,
    requests: RequestsState([]),
    presentations: PresentationsState([])
  );

  static AppState fromJson(dynamic json) => json == null ? initialState() : _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
