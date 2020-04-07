import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static final String _authorityKey = 'morpheus_authority_url';
  static final String _inspectorKey = 'morpheus_inspector_url';
  static final String _validatorKey = 'morpheus_validator_url';

  static Future<void> setAuthorityUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authorityKey, url);
  }

  static Future<void> setInspectorUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_inspectorKey, url);
  }

  static Future<void> setVerifierUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_validatorKey, url);
  }

  static Future<String> getAuthorityUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authorityKey);
  }

  static Future<String> getInspectorUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_inspectorKey);
  }

  static Future<String> getVerifierUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_validatorKey);
  }
}

class TestUrls {
  static final String emulatorAuthority = 'http://10.0.2.2:8080';
  static final String emulatorInspector = 'http://10.0.2.2:8081';
  static final String emulatorVerifier = 'http://10.0.2.2:8081';
  static final String gcpAuthority = 'http://34.76.108.115:8080';
  static final String gcpInspector = 'http://34.76.108.115:8081';
  static final String gcpVerifier = 'http://34.76.108.115:8081';
}