import 'dart:io';

import 'package:morpheus_sdk/crypto.dart';
import 'package:morpheus_sdk/utils.dart';

typedef GotActiveDid = void Function(String did);
typedef LoadFinished = void Function();

class VaultLoader {
  static final Log _log = Log(VaultLoader);
  
  static void load(CryptoAPI cryptoAPI, Directory appDocDir, GotActiveDid activeDidCallback, LoadFinished loadFinishedCallback) {
    try {
      _log.debug('Loading vault...');
      final vaultPath =
          '${appDocDir.path}/.config/prometheus/did_vault.dat';
      try {
        cryptoAPI.loadVault(vaultPath);
        _log.debug('Vault loaded from $vaultPath');
      } catch (e) {
        // TODO: FOR DEMO PURPOSES
        cryptoAPI.createVault(
            'include pear escape sail spy orange cute despair witness trouble sleep torch wire burst unable brass expose fiction drift clock duck oxygen aerobic already',
            vaultPath
        );
        _log.debug('Vault was not found, created a new one at $vaultPath');
      }

      while (cryptoAPI.listDids().length < 2) {
        _log.debug('Creating did: ${cryptoAPI.createDid()}...');
        _log.debug('Did created');
      }

      cryptoAPI.realLedger('http://35.187.56.222:4703'); // TESTNET
      activeDidCallback(cryptoAPI.listDids()[0]);
    } catch(e) {
      _log.error('Error using SDK: $e');
    } finally {
      loadFinishedCallback();
    }
  }
}