import 'dart:io';

import 'package:morpheus_common/sdk/native_sdk.dart';
import 'package:morpheus_common/utils/log.dart';

typedef GotActiveDid = void Function(String did);
typedef LoadFinished = void Function();

class VaultLoader {
  static final Log _log = Log(VaultLoader);
  
  static void load(Directory appDocDir, GotActiveDid activeDidCallback, LoadFinished loadFinishedCallback) {
    try {
      _log.debug('Loading vault...');
      final vaultPath =
          '${appDocDir.path}/.config/prometheus/did_vault.dat';
      try {
        NativeSDK.instance.loadVault(vaultPath);
        _log.debug('Vault loaded from $vaultPath');
      } catch (e) {
        // TODO: FOR DEMO PURPOSES
        NativeSDK.instance.createVault(
            'include pear escape sail spy orange cute despair witness trouble sleep torch wire burst unable brass expose fiction drift clock duck oxygen aerobic already',
            vaultPath
        );
        _log.debug('Vault was not found, created a new one at $vaultPath');
      }

      while (NativeSDK.instance.listDids().length < 2) {
        _log.debug('Creating did: ${NativeSDK.instance.createDid()}...');
        _log.debug('Did created');
      }

      NativeSDK.instance.realLedger('http://35.187.56.222:4703'); // TESTNET
      activeDidCallback(NativeSDK.instance.listDids()[0]);
    } catch(e) {
      _log.error('Error using SDK: $e');
    } finally {
      loadFinishedCallback();
    }
  }
}