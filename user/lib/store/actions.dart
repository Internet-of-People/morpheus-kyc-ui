class SetAuthorityApiUrlAction {
  final String url;

  SetAuthorityApiUrlAction(this.url);
}

class SetDidsAction {
  final List<String> dids;

  SetDidsAction(this.dids);
}

class SetWitnessRequestClaimDataAction {
  final Map<String, dynamic> claimData;

  SetWitnessRequestClaimDataAction(this.claimData);
}