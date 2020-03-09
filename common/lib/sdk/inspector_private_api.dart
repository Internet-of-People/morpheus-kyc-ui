import 'package:morpheus_common/utils/log.dart';

class InspectorPrivateApi {
  static Log _log = Log(InspectorPrivateApi);
  static InspectorPrivateApi _instance;
  final String _apiUrl;
  final String name;

  InspectorPrivateApi(this._apiUrl, this.name);

  static InspectorPrivateApi get instance => _instance == null ? throw Exception('InspectorPrivateApi is no yet set') : _instance;

  static InspectorPrivateApi setAsEmulator() => _instance = InspectorPrivateApi('http://10.0.2.2:8080', 'Inspector');

  static InspectorPrivateApi setAsRealDevice(url) => _instance = InspectorPrivateApi(url, 'Inspector');

  // TBD
}