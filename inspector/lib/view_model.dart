import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_common/sdk/http_tools.dart';
import 'package:morpheus_common/sdk/io.dart';
import 'package:morpheus_common/sdk/validator_api.dart';
import 'package:morpheus_common/utils/log.dart';

part 'view_model.g.dart';

class ValidationItem {
  final bool isError;
  final String text;
  final String detail;

  ValidationItem(this.isError, this.text, this.detail);
}

class ValidationItems {
  final List<ValidationItem> _items;

  ValidationItems(this._items);

  UnmodifiableListView<ValidationItem> get items => UnmodifiableListView(_items);
  bool get hasWarning => _items.isNotEmpty;
  bool get hasError => _items.any((i) => i.isError);
}

class Discount {
  final String address;
  final int percent;

  Discount(this.address, this.percent);

  static Discount invalid({ String address = 'unknown' }) {
    return Discount(address, 0);
  }

  static Discount valid({ @required String address, @required int percent }) {
    return Discount(address, percent);
  }
}

class AppViewModel {
  final Log _log = Log(AppViewModel);
  String _url;
  Future<SignedPresentation> _presentation;
  Future<ValidationItems> _validation;
  Future<Discount> _discount;

  String get url => _url;
  Future<SignedPresentation> get presentation => _presentation;
  Future<ValidationItems> get validation => _validation;
  Future<Discount> get discount => _discount;

  void gotUrl(String url) {
    _log.debug('Got URL $url');
    _url = url;
    _presentation = _download();
  }

  Future<SignedPresentation> _download() async {
    try {
      final jsonString = await HttpTools.httpGet(url);
      final result = SignedPresentation.fromJson(json.decode(jsonString));
      _validation = _validate(result);
      return result;
    } catch (e) {
      _validation = Future.value(_singleError('Error while downloading $url', e.toString()));
      _discount = Future.value(Discount.invalid());
      return null;
    }
  }

  Future<ValidationItems> _validate(SignedPresentation presentation) async {
    final provenClaim = presentation?.content?.provenClaims?.first;
    if (provenClaim == null) {
      _discount = Future.value(Discount.invalid());
      return _singleError('No claim found in presentation', '');
    }

    try {
      final request = ValidationRequest(
        provenClaim.claim.subject, // Claimant might be different from subject
        presentation.signature.publicKey,
        // Also, the did might only have the id of this publicKey added
        null,
        null,
      );
      final result = await ValidatorApi.instance.validate(request);

      final items = result.errors.map((i) => ValidationItem(true, i, '')).toList() +
        result.warnings.map((i) => ValidationItem(false, i, '')).toList();
      _discount = _calculateDiscount(provenClaim.claim);
      return ValidationItems(items);
    } catch (e) {
      _discount = Future.value(Discount.invalid());
      return _singleError('Error validating on Hydra node', e.toString());
    }
  }

  ValidationItems _singleError(String title, String detail) {
    final errorItem = ValidationItem(true, title, detail);
    return ValidationItems([errorItem]);
  }

  Future<Discount> _calculateDiscount(Claim claim) async {
    final card = AddressProof.fromJson(claim.content);
    final address = card.address;
    final percent = _calculatePercent(address);
    return Discount.valid(address: address, percent: percent);
  }

  int _calculatePercent(String address) {
    if (address.contains('Berlin')) {
      return 10;
    } else if (address.contains('Germany')) {
      return 5;
    } else {
      return 0;
    }
  }
}

@JsonSerializable(explicitToJson: true)
class AddressProof {
  final String address;

  AddressProof({ @required this.address });

  factory AddressProof.fromJson(Map<String, dynamic> json) => _$DigitalIdCardFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalIdCardToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PlaceOfBirth {
  final String country;
  final String city;

  PlaceOfBirth({ @required this.country, @required this.city });

  factory PlaceOfBirth.fromJson(Map<String, dynamic> json) => _$PlaceOfBirthFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOfBirthToJson(this);
}
