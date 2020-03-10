import 'package:morpheus_common/sdk/io.dart';

class ScanUrlAction {
  final String url;

  ScanUrlAction(this.url);
}

class UrlDownloadedAction {
  final String presentationJson;

  UrlDownloadedAction(this.presentationJson);
}

class UrlDownloadErrorAction {
  final String error;

  UrlDownloadErrorAction(this.error);
}

class Validated {
  final SignedPresentation presentation;
  final List<String> errors;
  final List<String> warnings;

  Validated(this.presentation, this.errors, this.warnings);
}

class DiscountCalculated {
  final int discount;

  DiscountCalculated(this.discount);
}

class Restarted {
}
