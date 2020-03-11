import 'package:morpheus_kyc_user/store/state/presentations_state.dart';
import 'package:morpheus_kyc_user/store/state/requests_state.dart';

class AddRequestAction {
  final SentRequest request;

  AddRequestAction(this.request);
}

class AddPresentationAction {
  final CreatedPresentation presentation;

  AddPresentationAction(this.presentation);
}