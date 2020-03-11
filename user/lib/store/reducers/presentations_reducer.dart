import 'package:morpheus_kyc_user/store/actions/actions.dart';
import 'package:morpheus_kyc_user/store/state/presentations_state.dart';
import 'package:redux/redux.dart';

final presentationsReducer = combineReducers<PresentationsState>([
  TypedReducer<PresentationsState, AddPresentationAction>(_addPresentation)
]);

PresentationsState _addPresentation(PresentationsState oldState, AddPresentationAction action) {
  return oldState.copy()..add(action.presentation);
}