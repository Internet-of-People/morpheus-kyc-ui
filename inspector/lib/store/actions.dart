class ScanUrlAction {
  final String url;

  ScanUrlAction(this.url);
}

class UrlDownloadedAction {
  final String presentationJson;

  UrlDownloadedAction(this.presentationJson);
}

class SignaturesValidated {
  final List<String> signatureErrors;

  SignaturesValidated(this.signatureErrors);
}

class DiscountCalculated {
  final int discount;

  DiscountCalculated(this.discount);
}

class Restarted {
}
